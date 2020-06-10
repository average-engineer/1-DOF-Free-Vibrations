function [displacement_t,velocity_t] = one_dof_system_analytical_solver(mass,damping_c,spring_stiffness,time,x_initial,xdot_initial)

%computing the damping coefficient (damping ratio*natural eigen frequency)
damping_coeff = damping_c/(2*mass);

%eigen natural frequency
omega_n = sqrt(spring_stiffness/mass);

%solutions/roots of the characteristic equation
lambda = [-damping_coeff + sqrt((damping_coeff)^2 - (omega_n)^2) ; -damping_coeff - sqrt((damping_coeff)^2 - (omega_n)^2)];

%integration constants
C1 = (xdot_initial - lambda(2)*x_initial)/(lambda(1) - lambda(2));

C2 = (lambda(1)*x_initial - xdot_initial)/(lambda(1) - lambda(2));

%displacement and velocity equations
%we have to ensure that only the real values are taken into consideration
displacement_t = real(C1*exp(lambda(1)*time) + C2*exp(lambda(2)*time));
velocity_t = real(lambda(1)*C1*exp(lambda(1)*time) + lambda(2)*C2*exp(lambda(2)*time));