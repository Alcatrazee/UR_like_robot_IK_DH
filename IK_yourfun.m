% function result = IK_yourfun()

RDK = Robolink();
robot = RDK.Item('yourfun_robot');
global limits
limits = deg2rad([-170,170;-115,115;-130,130;-135,135;-135,135;-135,135]);

% alpha a d theta_offset
dh_param = [0,    0,     45,     0
    pi/2,  0,   51.5,  pi/2
    0,   120,      0,     0
    0,   120,      0, -pi/2
    -pi/2, 0,   66.7,  pi/2
    pi/2,  0,   51.7,     0];

T = robot.Pose();

ik = zeros(8,7);

% find theta1
P0_5 = T*[0,0,-dh_param(6,3),1]';
P0_5_xy = P0_5(1:2);
l1 = norm(P0_5_xy);
l2 = dh_param(2,3);
phi1 = atan2(P0_5_xy(2),P0_5_xy(1));
phi2 = norm(asin(l2/l1));

theta1_1 = phi1 + phi2;
if(phi1>0)
    theta1_2 = (phi1-phi2) - pi;
else
    theta1_2 = pi - (phi2-phi1);
end

theta1_1 = limit_angle(theta1_1,limits(1,:));
theta1_2 = limit_angle(theta1_2,limits(1,:));

for i=1:8
    if(i<5)
        ik(i,1) = theta1_1;
    else
        ik(i,1) = theta1_2;
    end
end

T1_1 = T_mdh(dh_param(1,:),theta1_1);
T1_2 = T_mdh(dh_param(1,:),theta1_2);

% get theta 6 1
T1_6_1 = T1_1\T;
T1_6_2 = T1_2\T;
theta6_1_1 = atan2(-T1_6_1(2,2),T1_6_1(2,1));
theta6_1_2 = theta6_1_1 - pi;
theta6_2_1 = atan2(-T1_6_2(2,2),T1_6_2(2,1));
theta6_2_2 = theta6_2_1 - pi;

theta6_1_1 = limit_angle(theta6_1_1,limits(6,:));
theta6_1_2 = limit_angle(theta6_1_2,limits(6,:));
theta6_2_1 = limit_angle(theta6_2_1,limits(6,:));
theta6_2_2 = limit_angle(theta6_2_2,limits(6,:));

ik(1,6) = theta6_1_1;
ik(2,6) = theta6_1_1;
ik(3,6) = theta6_1_2;
ik(4,6) = theta6_1_2;
ik(5,6) = theta6_2_1;
ik(6,6) = theta6_2_1;
ik(7,6) = theta6_2_2;
ik(8,6) = theta6_2_2;

T1_5_1_1 = T1_6_1/T_mdh(dh_param(6,:),theta6_1_1);
T1_5_1_2 = T1_6_1/T_mdh(dh_param(6,:),theta6_1_2);
T1_5_2_1 = T1_6_2/T_mdh(dh_param(6,:),theta6_2_1);
T1_5_2_2 = T1_6_2/T_mdh(dh_param(6,:),theta6_2_2);

theta5_1_1 = atan2(-T1_5_1_1(2,2),T1_5_1_1(2,1));
theta5_1_2 = atan2(-T1_5_1_2(2,2),T1_5_1_2(2,1));
theta5_2_1 = atan2(-T1_5_2_1(2,2),T1_5_2_1(2,1));
theta5_2_2 = atan2(-T1_5_2_2(2,2),T1_5_2_2(2,1));

ik(1,5) = theta5_1_1;
ik(2,5) = theta5_1_1;
ik(3,5) = theta5_1_2;
ik(4,5) = theta5_1_2;
ik(5,5) = theta5_2_1;
ik(6,5) = theta5_2_1;
ik(7,5) = theta5_2_2;
ik(8,5) = theta5_2_2;

% get theta 2 3 4
[theta_234_1_1,succ1] = get_theta234(dh_param,theta6_1_1,theta5_1_1,theta1_1,T);
[theta_234_1_2,succ2] = get_theta234(dh_param,theta6_1_2,theta5_1_2,theta1_1,T);
[theta_234_2_1,succ3] = get_theta234(dh_param,theta6_2_1,theta5_2_1,theta1_2,T);
[theta_234_2_2,succ4] = get_theta234(dh_param,theta6_2_2,theta5_2_2,theta1_2,T);

succ_mat = [succ1;succ2;succ3;succ4];

ik(1:2,2:4) = theta_234_1_1;
ik(3:4,2:4) = theta_234_1_2;
ik(5:6,2:4) = theta_234_2_1;
ik(7:8,2:4) = theta_234_2_2;


for i=1:8
    angle_valid = 1;
    for j=1:6
        if(j == 2)
           if(succ_mat(i) == 1)
              j = 5; 
           elseif(succ_mat(i) == 0)
              ik(i,7) = 0;
              angle_valid = 0;
              break;
           end
        end
        if(ik(i,j)>limits(j,2)||ik(i,j)<limits(j,1))
            ik(i,7) = 0;
            angle_valid = 0;
            break
        end
    end
    if(angle_valid == 1)
        ik(i,7) = 1;
    elseif(angle_valid == 0)
        ik(i,7) = 0;
    end
end

IK = [rad2deg(ik(:,1:6)),ik(:,7)]
solution = [];
for i = 1:8
   if(IK(i,7)==1)
      solution = [solution ;IK(i,:)]; 
   end
end
solution
groud_truth = robot.SolveIK_All(T)'


% end

function angle = limit_angle(angle,range)  
    if(angle>range(2))
        angle = angle - pi*2;
    elseif(angle<range(1))
        angle = angle + pi*2;
    end
end

function result = in_range(number,range)
    if(number>range(2)||number<range(1))
        result = 0;
    else
        result = 1;
    end
end

function [theta234,succ] = get_theta234(dh_param,theta6,theta5,theta1,T)
global limits
% dh_param(6,:) theta6 theta5 theta1
T6 = T_mdh(dh_param(6,:),theta6);
T5 = T_mdh(dh_param(5,:),theta5);
T1 = T_mdh(dh_param(1,:),theta1);

T2T3T4 = T1\T/T6/T5;

l1 = dh_param(3,2);
l2 = dh_param(4,2);
l3 = sqrt(T2T3T4(1,4)^2+T2T3T4(3,4)^2);

succ = zeros(2,1);

if(l1+l2<l3)
    theta234 = zeros(2,3);
    return
end
if(l3 == sqrt(l1^2+l2^2))
    theta3_1 = 0;
    theta2_1 = 0;
else
    theta_hat = acos((l1^2+l2^2-l3^2)/(2*l1*l2));
    theta_hat2 = acos((l3^2+l1^2-l1^2)/(2*l1*l3));
    theta_hat3 = atan2(T2T3T4(3,4),T2T3T4(1,4));
    theta3_1 = -(pi-theta_hat);
    theta2_1 = theta_hat2 + theta_hat3 - pi/2;
end
T2_1 = T_mdh(dh_param(2,:),theta2_1);
T3_1 = T_mdh(dh_param(3,:),theta3_1);
T4_1 = inv(T3_1)*inv(T2_1)*inv(T1)*T*inv(T6)*inv(T5);
theta4_1 = atan2(T4_1(2,1),T4_1(1,1))+pi/2;

theta4_1 = limit_angle(theta4_1,limits(4,:));
theta3_1 = limit_angle(theta3_1,limits(3,:));
theta2_1 = limit_angle(theta2_1,limits(2,:));

if(in_range(theta2_1,limits(2,:))==0||in_range(theta3_1,limits(3,:))==0||in_range(theta4_1,limits(4,:))==0)
    succ(1) = 0;
else
    succ(1) = 1;
end

theta3_2 = -theta3_1;
theta2_2 = theta2_1 - 2*theta_hat2;
T2_2 = T_mdh(dh_param(2,:),theta2_2);
T3_2 = T_mdh(dh_param(3,:),theta3_2);
T4_2 = inv(T3_2)*inv(T2_2)*inv(T1)*T*inv(T6)*inv(T5);
theta4_2 = atan2(T4_2(2,1),T4_2(1,1))+pi/2;

theta4_2 = limit_angle(theta4_2,limits(4,:));
theta3_2 = limit_angle(theta3_2,limits(3,:));
theta2_2 = limit_angle(theta2_2,limits(2,:));

if(in_range(theta2_2,limits(2,:))==0||in_range(theta3_2,limits(3,:))==0||in_range(theta4_2,limits(4,:))==0)
    succ(2) = 0;
else
    succ(2) = 1;
end

theta234 = [theta2_1 theta3_1 theta4_1;theta2_2 theta3_2 theta4_2];
end