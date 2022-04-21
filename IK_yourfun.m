% function result = IK_yourfun()

% global RDK;
% global robot;
% global robot_base;
RDK = Robolink();
robot = RDK.Item('yourfun_robot');

limits = deg2rad([-170,170;-110,110;-130,130;-135,135;-135,135;-135,135]);

% alpha a d theta_offset
dh_param = [0,    0,     45,     0
           pi/2,  0,   51.5,  pi/2
           0,   120,      0,     0
           0,   120,      0, -pi/2
           -pi/2, 0,   66.7,  pi/2
           pi/2,  0,   51.7,     0];

T = robot.Pose();

% find theta1
P0_5 = T*[0,0,-dh_param(6,3),1]';
P0_5_xy = P0_5(1:2);
l1 = norm(P0_5_xy);
l2 = dh_param(2,3);
phi1 = atan2(P0_5_xy(2),P0_5_xy(1));
phi2 = asin(l2/l1);

theta1_1 = phi1 + phi2;
if(phi1>0)
    theta1_2 = (phi1-phi2) - pi;
else
    theta1_2 = pi - (phi2-phi1);
end



% compute theta 5, only for leaning forward
T1_1 = T_mdh(dh_param(1,:),theta1_1);
P1_6_1 = inv(T1_1)*T(:,4);
P1_5_1 = inv(T1_1)*P0_5;

if(P1_6_1(1)<P1_5_1(1))
    theta5_1 = -asin((-dh_param(2,3)-P1_6_1(2))/dh_param(6,3));
else
    theta5_1 = -(pi - asin((-dh_param(2,3)-P1_6_1(2))/dh_param(6,3)));
end
if(theta5_1<limits(5,1))
    theta5_1 = theta5_1 + 2*pi;
elseif(theta5_1>limits(5,2))
    theta5_1 = theta5_1 - 2*pi;
end

% theta 5 leaning backward
T1_2 = T_mdh(dh_param(1,:),theta1_2);
P1_6_2 = inv(T1_2)*T(:,4);
P1_5_2 = inv(T1_2)*P0_5;

if(P1_6_2(1)<P1_5_2(1))
    theta5_2 = -asin((-dh_param(2,3)-P1_6_2(2))/dh_param(6,3));
else
    theta5_2 = -(pi - asin((-dh_param(2,3)-P1_6_2(2))/dh_param(6,3)));
end
if(theta5_2<limits(5,1))
    theta5_2 = theta5_2 + 2*pi;
elseif(theta5_2>limits(5,2))
    theta5_2 = theta5_2 - 2*pi;
end

% get theta 6 1

S234 = T(3,3)/cos(theta5_1);
C234 = (T(1,3)+sin(theta1_1)*sin(theta5_1))/(cos(theta1_1)*cos(theta5_1));

C6 = (T(3,2)-(S234*sin(theta5_1))*T(3,1)/C234)/(C234+sin(theta5_1)^2*S234^2/C234);
S6 = (T(3,1)+S234*sin(theta5_1)*C6)/C234;
theta6_1 = atan2(S6,C6);

% get theta6 2
S234 = T(3,3)/cos(theta5_2);
C234 = (T(1,3)+sin(theta1_2)*sin(theta5_2))/(cos(theta1_2)*cos(theta5_2));

C6 = (T(3,2)-(S234*sin(theta5_2))*T(3,1)/C234)/(C234+sin(theta5_2)^2*S234^2/C234);
S6 = (T(3,1)+S234*sin(theta5_2)*C6)/C234;
theta6_2 = atan2(S6,C6);

% get theta 2 3 4
T6_1 = T_mdh(dh_param(6,:),theta6_1);
T5_1 = T_mdh(dh_param(5,:),theta5_1);
T1_1 = T_mdh(dh_param(1,:),theta1_1);

T2T3T4 = inv(T1_1)*T*inv(T6_1)*inv(T5_1);

l1 = 120;
l2 = 120;
l3 = sqrt(T2T3T4(1,4)^2+T2T3T4(3,4)^2);

theta_hat = acos((l1^2+l2^2-l3^2)/(2*l1*l2));
theta_hat2 = acos((l3^2+l1^2-l1^2)/(2*l1*l3));
theta_hat3 = atan2(T2T3T4(3,4),T2T3T4(1,4));

theta3_1 = -(pi-theta_hat);
theta2_1 = theta_hat2 + theta_hat3 - pi/2;
T2_1 = T_mdh(dh_param(2,:),theta2_1);
T3_1 = T_mdh(dh_param(3,:),theta3_1);
T4_1 = inv(T3_1)*inv(T2_1)*inv(T1_1)*T*inv(T6_1)*inv(T5_1);
theta4_1 = atan2(T4_1(2,1),T4_1(1,1))+pi/2;

theta3_2 = -theta3_1;
theta2_2 = theta2_1 - 2*theta_hat2;
T2_2 = T_mdh(dh_param(2,:),theta2_2);
T3_2 = T_mdh(dh_param(3,:),theta3_2);
T4_2 = inv(T3_2)*inv(T2_2)*inv(T1_1)*T*inv(T6_1)*inv(T5_1);
theta4_2 = atan2(T4_2(2,1),T4_2(1,1))+pi/2;


result = rad2deg([theta1_1,theta2_1,theta3_1,theta4_1,theta5_1,theta6_1;
          theta1_1,theta2_2,theta3_2,theta4_2,theta5_1,theta6_1]);



T6_2 = T_mdh(dh_param(6,:),theta6_2);
T5_2 = T_mdh(dh_param(5,:),theta5_2);
T1_2 = T_mdh(dh_param(1,:),theta1_2);

T2T3T4 = inv(T1_2)*T*inv(T6_2)*inv(T5_2);

l1 = 120;
l2 = 120;
l3 = sqrt(T2T3T4(1,4)^2+T2T3T4(3,4)^2);

theta_hat = acos((l1^2+l2^2-l3^2)/(2*l1*l2));
theta_hat2 = acos((l3^2+l1^2-l1^2)/(2*l1*l3));
theta_hat3 = atan2(T2T3T4(3,4),T2T3T4(1,4));

theta3_1 = (pi-theta_hat);                  % elbow up
theta2_1 = theta_hat3 - pi/2 - theta_hat2;  
T2_1 = T_mdh(dh_param(2,:),theta2_1);
T3_1 = T_mdh(dh_param(3,:),theta3_1);
T4_1 = inv(T3_1)*inv(T2_1)*inv(T1_2)*T*inv(T6_2)*inv(T5_2);
theta4_1 = atan2(T4_1(2,1),T4_1(1,1)) + pi/2;

theta3_2 = -theta3_1;
theta2_2 = theta2_1 + 2*theta_hat2;
T2_2 = T_mdh(dh_param(2,:),theta2_2);
T3_2 = T_mdh(dh_param(3,:),theta3_2);
T4_2 = inv(T3_2)*inv(T2_2)*inv(T1_2)*T*inv(T6_2)*inv(T5_2);
theta4_2 = atan2(T4_2(2,1),T4_2(1,1)) + pi/2;

result = [result; rad2deg([theta1_2,theta2_1,theta3_1,theta4_1,theta5_2,theta6_2;
        theta1_2,theta2_2,theta3_2,theta4_2,theta5_2,theta6_2])];

% end