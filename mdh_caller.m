% alpha a d theta_offset
syms t1 t2 t3 t4 t5 t6
dh_param = [0,    0,     45,     0
           pi/2,  0,   51.5,  pi/2
           0,   120,      0,     0
           0,   120,      0, -pi/2
           -pi/2, 0,   66.7,  pi/2
           pi/2,  0,   51.7,     0];
       
% theta_vec = [0,0,0,0,0,0];
theta_vec = [t1 t2 t3 t4 t5 t6];

% theta_vec = deg2rad([-87.210000, -50.780000, -75.130000, -64.870000, 28.930000, -106.950000]);
[gst,T] = FK_my(dh_param,theta_vec)
