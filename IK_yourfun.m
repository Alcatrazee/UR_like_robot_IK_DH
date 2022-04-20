% function result = IK_yourfun()

% global RDK;
% global robot;
% global robot_base;
% RDK = Robolink();
% robot = RDK.Item('yourfun_robot');

limits = deg2rad([-170,170;-110,110;-130,130;-135,135;-135,135;-135,135]);

% alpha a d theta_offset
dh_param = [0,    0,     45,     0
           pi/2,  0,   51.5,  pi/2
           0,   120,      0,     0
           0,   120,      0, -pi/2
           -pi/2, 0,   66.7,  pi/2
           pi/2,  0,   51.7,     0];

T =[    -0.187860,     0.701354,    -0.687613,   209.541440 ;
      0.903670,    -0.150869,    -0.400773,  -126.119980 ;
     -0.384823,    -0.696664,    -0.605450,    39.349264 ;
      0.000000,     0.000000,     0.000000,     1.000000 ];

% find theta1
P0_5 = T*[0,0,-dh_param(6,3),1]';
P0_5_xy = P0_5(1:2);
l1 = norm(P0_5_xy);
l2 = dh_param(2,3);
phi1 = atan2(P0_5_xy(2),P0_5_xy(1));
phi2 = asin(l2/l1);

theta1 = phi1 + phi2;

rad2deg(theta1)

T1 = T_mdh(dh_param(1,:),theta1);

% compute theta 5, only for leaning forward
P1_6 = inv(T1)*T(:,4);
P1_5 = inv(T1)*P0_5;

if(P1_6(1)<P1_5(1))
    theta5 = -asin((-dh_param(2,3)-P1_6(2))/dh_param(6,3));
else
    theta5 = -(pi - asin((-dh_param(2,3)-P1_6(2))/dh_param(6,3)));
end
if(theta5<limits(5,1))
    theta5 = theta5 + 2*pi;
elseif(theta5>limits(5,2))
    theta5 = theta5 - 2*pi;
end

rad2deg(theta5)

% get theta 6

S234 = T(3,3)/cos(theta5);
C234 = (T(1,3)+sin(theta1)*sin(theta5))/(cos(theta1)*cos(theta5));

C6 = (T(3,2)-(S234*sin(theta5))*T(3,1)/C234)/(C234+sin(theta5)^2*S234^2/C234);
S6 = (T(3,1)+S234*sin(theta5)*C6)/C234;
theta6 = atan2(S6,C6)

rad2deg(theta6)


% end