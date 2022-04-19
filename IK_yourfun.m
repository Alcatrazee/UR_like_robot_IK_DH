% function result = IK_yourfun()

limits = deg2rad([-170,170;-110,110;-130,130;-135,135;-135,135;-135,135]);

% alpha a d theta_offset
dh_param = [0,    0,     45,     0
           pi/2,  0,   51.5,  pi/2
           0,   120,      0,     0
           0,   120,      0, -pi/2
           -pi/2, 0,   66.7,  pi/2
           pi/2,  0,   51.7,     0];

T =[     0.880342,    -0.474128,    -0.014177,  -212.371348 ;
     -0.277234,    -0.538550,     0.795679,  -121.320896 ;
     -0.384889,    -0.696539,    -0.605553,    39.373251 ;
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

% end