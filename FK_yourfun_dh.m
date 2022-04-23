function result = FK_yourfun_dh(theta_vector)

t1 = theta_vector(1);
t2 = theta_vector(2);
t3 = theta_vector(3);
t4 = theta_vector(4);
t5 = theta_vector(5);
t6 = theta_vector(6);

result = [  (-cos(t1)*cos(t2+t3+t4)*sin(t5)-sin(t1)*cos(t5))*cos(t6)+(-cos(t1)*sin(t2+t3+t4))*sin(t6), (-cos(t1)*cos(t2+t3+t4)*sin(t5)-sin(t1)*cos(t5))*(-sin(t6))+( -cos(t1)*sin(t2+t3+t4))*cos(t6), -(-cos(t1)*cos(t2+t3+t4)*cos(t5)+sin(t1)*sin(t5)), -51.7*(-cos(t1)*cos(t2+t3+t4)*cos(t5)+sin(t1)*sin(t5))+ (-66.7*cos(t1)*sin(t2+t3+t4)+51.5*sin(t1)-120*cos(t1)*(sin(t2)+sin(t2+t3)))
            (-sin(t1)*cos(t2+t3+t4)*sin(t5)+cos(t1)*cos(t5))*cos(t6)+(-sin(t1)*sin(t2+t3+t4))*sin(t6), (-sin(t1)*cos(t2+t3+t4)*sin(t5)+cos(t1)*cos(t5))*(-sin(t6))+( -sin(t1)*sin(t2+t3+t4))*cos(t6), -(-sin(t1)*cos(t2+t3+t4)*cos(t5)-cos(t1)*sin(t5)), -51.7*(-sin(t1)*cos(t2+t3+t4)*cos(t5)-cos(t1)*sin(t5))+ (-66.7*sin(t1)*sin(t2+t3+t4)-51.5*cos(t1)-120*sin(t1)*(sin(t2+t3)+sin(t2)))
            (-sin(t2+t3+t4)*sin(t5))*cos(t6)+cos(t2+t3+t4)*sin(t6)                                   , (-sin(t2+t3+t4)*sin(t5))*(-sin(t6))+cos(t2+t3+t4)*cos(t6)                                    , -(-sin(t2+t3+t4)*cos(t5))                        , -51.7*(-sin(t2+t3+t4)*cos(t5))+(66.7*cos(t2+t3+t4)+120*(cos(t2+t3)+cos(t2))+45)
            0                                                                                        ,                                          0                                                   ,   0                                              ,  1   ];
end