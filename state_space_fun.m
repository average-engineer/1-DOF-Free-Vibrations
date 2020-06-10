function [dwdt] = statespace(t,w,mass,spring_stiffness,damping_coeff)
w1 = w(1);%x 
w2 = w(2);%xdot
dw1dt = w2;%xdot = xdot
dw2dt = -(damping_coeff/mass)*w2 - (spring_stiffness/mass)*w1;%x2dot = -(c/m)*xdot - (k/m)*x
dwdt = [dw1dt;dw2dt];
end