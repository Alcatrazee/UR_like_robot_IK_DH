function [gst,T] = FK_my(dh_param,theta_vec)

% T = zeros(4,4,6);
g_st = eye(4);
for i=1:6
   T(:,:,i) = T_mdh(dh_param(i,:),theta_vec(i)); 
   g_st = g_st*T(:,:,i);
end

gst = g_st;

end
