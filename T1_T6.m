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
            