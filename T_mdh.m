function T = T_mdh(mdh_param,theta)

if(length(mdh_param)==4)
    alpha = mdh_param(1);
    a = mdh_param(2);
    d = mdh_param(3);
    offset = mdh_param(4);
else
    error('please input param in [alpha a d theta offset] format.');
end
% this function is to compute the T matrix for a link in MDH way
T = Rotx(alpha)*Translate_x(a)*Rotz(theta+offset)*Translate_z(d);

end