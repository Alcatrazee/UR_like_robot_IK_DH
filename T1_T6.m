clear
syms t1 t2 t3 t4 t5 t6

dh_param = [0,    0,     45,     0
           pi/2,  0,   51.5,  pi/2
           0,   120,      0,     0
           0,   120,      0, -pi/2
           -pi/2, 0,   66.7,  pi/2
           pi/2,  0,   51.7,     0];


%    T = T_mdh(dh_param(i,:),t); 


T1T2T3 = [ -sin(t2 + t3)*cos(t1), -cos(t2 + t3)*cos(t1),  sin(t1),   (103*sin(t1))/2 - 120*cos(t1)*sin(t2)
         -sin(t2 + t3)*sin(t1), -cos(t2 + t3)*sin(t1), -cos(t1), - (103*cos(t1))/2 - 120*sin(t1)*sin(t2)
                  cos(t2 + t3),         -sin(t2 + t3),        0,                        120*cos(t2) + 45
                             0,                     0,        0,                                       1];

T1T2T3T4 = [cos(t1)*cos(t2+t3+t4), -cos(t1)*sin(t2+t3+t4), sin(t1), 51.5*sin(t1)-120*cos(t1)*sin(t2)-120*sin(t2+t3)*cos(t1);
            sin(t1)*cos(t2+t3+t4), -sin(t1)*sin(t2+t3+t4), -cos(t1), -51.5*cos(t1)-120*sin(t1)*sin(t2+t3)-120*sin(t1)*sin(t2);
            sin(t2+t3+t4),             cos(t2+t3+t4),          0  ,  120*cos(t2+t3)+120*cos(t2)+45;
            0                   ,           0                ,0   ,                     1];
        
T1T2T3T4T5 = [-cos(t1)*cos(t2+t3+t4)*sin(t5)-sin(t1)*cos(t5), -cos(t1)*cos(t2+t3+t4)*cos(t5)+sin(t1)*sin(t5), -cos(t1)*sin(t2+t3+t4), -66.7*cos(t1)*sin(t2+t3+t4)+51.5*sin(t1)-120*cos(t1)*(sin(t2)+sin(t2+t3))
              -sin(t1)*cos(t2+t3+t4)*sin(t5)+cos(t1)*cos(t5), -sin(t1)*cos(t2+t3+t4)*cos(t5)-cos(t1)*sin(t5), -sin(t1)*sin(t2+t3+t4), -66.7*sin(t1)*sin(t2+t3+t4)-51.5*cos(t1)-120*sin(t1)*(sin(t2+t3)+sin(t2))
              -sin(t2+t3+t4)*sin(t5)                        , -sin(t2+t3+t4)*cos(t5)                         , cos(t2+t3+t4)         ,  66.7*cos(t2+t3+t4)+120*(cos(t2+t3)+cos(t2))+45  
              0                                             , 0                                             , 0                     ,   1];
          
T1T2T3T4T5T6 = [(-cos(t1)*cos(t2+t3+t4)*sin(t5)-sin(t1)*cos(t5))*cos(t6)+(-cos(t1)*sin(t2+t3+t4))*sin(t6), (-cos(t1)*cos(t2+t3+t4)*sin(t5)-sin(t1)*cos(t5))*(-sin(t6))+( -cos(t1)*sin(t2+t3+t4))*cos(t6), -(-cos(t1)*cos(t2+t3+t4)*cos(t5)+sin(t1)*sin(t5)), -51.7*(-cos(t1)*cos(t2+t3+t4)*cos(t5)+sin(t1)*sin(t5))+ (-66.7*cos(t1)*sin(t2+t3+t4)+51.5*sin(t1)-120*cos(t1)*(sin(t2)+sin(t2+t3)))
                (-sin(t1)*cos(t2+t3+t4)*sin(t5)+cos(t1)*cos(t5))*cos(t6)+(-sin(t1)*sin(t2+t3+t4))*sin(t6), (-sin(t1)*cos(t2+t3+t4)*sin(t5)+cos(t1)*cos(t5))*(-sin(t6))+( -sin(t1)*sin(t2+t3+t4))*cos(t6), -(-sin(t1)*cos(t2+t3+t4)*cos(t5)-cos(t1)*sin(t5)), -51.7*(-sin(t1)*cos(t2+t3+t4)*cos(t5)-cos(t1)*sin(t5))+ (-66.7*sin(t1)*sin(t2+t3+t4)-51.5*cos(t1)-120*sin(t1)*(sin(t2+t3)+sin(t2)))
                (-sin(t2+t3+t4)*sin(t5))*cos(t6)+cos(t2+t3+t4)*sin(t6)                                   , (-sin(t2+t3+t4)*sin(t5))*(-sin(t6))+cos(t2+t3+t4)*cos(t6)                                    , -(-sin(t2+t3+t4)*cos(t5))                        , -51.7*(-sin(t2+t3+t4)*cos(t5))+(66.7*cos(t2+t3+t4)+120*(cos(t2+t3)+cos(t2))+45)
                0                                                                                        ,                                          0                                                   ,   0                                              ,  1   ];
       
T2T3T4T5T6 =    [ - sin(t2 + t3 + t4)*sin(t6) - cos(t2 + t3 + t4)*cos(t6)*sin(t5), cos(t2 + t3 + t4)*sin(t5)*sin(t6) - sin(t2 + t3 + t4)*cos(t6), cos(t2 + t3 + t4)*cos(t5), (517*cos(t2 + t3 + t4)*cos(t5))/10 - 120*sin(t2 + t3) - 120*sin(t2) - (667*sin(t2 + t3 + t4))/10
                                                                 cos(t5)*cos(t6),                                              -cos(t5)*sin(t6),                   sin(t5),                                                                         (517*sin(t5))/10 - 103/2
                   cos(t2 + t3 + t4)*sin(t6) - sin(t2 + t3 + t4)*cos(t6)*sin(t5), cos(t2 + t3 + t4)*cos(t6) + sin(t2 + t3 + t4)*sin(t5)*sin(t6), sin(t2 + t3 + t4)*cos(t5), (667*cos(t2 + t3 + t4))/10 + 120*cos(t2 + t3) + 120*cos(t2) + (517*sin(t2 + t3 + t4)*cos(t5))/10
                                                                               0,                                                             0,                         0,                                                                                                1]   ;      
                                                                           
T6 = [ cos(t6),-sin(t6),  0,    0
 0, 0, -1,-517/10
   sin(t6),    cos(t6),0, 0
  0,   0,   0, 1];
                                                             
T2T3T4T5 =  [ -cos(t2 + t3 + t4)*sin(t5), -cos(t2 + t3 + t4)*cos(t5), -sin(t2 + t3 + t4), - (667*sin(t2 + t3 + t4))/10 - 120*sin(t2 + t3) - 120*sin(t2)
                                cos(t5),                   -sin(t5),                  0,                                                        -103/2
             -sin(t2 + t3 + t4)*sin(t5), -sin(t2 + t3 + t4)*cos(t5),  cos(t2 + t3 + t4),   (667*cos(t2 + t3 + t4))/10 + 120*cos(t2 + t3) + 120*cos(t2)
                                      0,                          0,                  0,                                                             1];
T5 = [-sin(t5) -cos(t5) 0 0
      0        0        1  66.7
    -cos(t5)     sin(t5)   0 0
    0 0 0 1];

inv_T5 = [-sin(t5) 0 -cos(t5) 0
          -cos(t5) 0  sin(t5) 0
           0       1    0     -66.7
           0       0    0       1];
       
T2T3T4 = T2T3T4T5*inv_T5