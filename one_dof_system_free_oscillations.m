%% Solving Analylitically
clear all
close all
clc
%system parameters
%mass
m = 750;
%spring stiffness
k = 50000;
%damping
c = 1000;
%time span
time_span = [0:0.01:5];
%displacement initial conditions
x_0 = 0.01;
%velocity initial consitions
xdot_0 = 0;
d = (-(c/(2*m)) + sqrt((c/(2*m))^2 - (k/m)));
e = (-(c/(2*m)) - sqrt((c/(2*m))^2 - (k/m)))
%solving the system analytically
[x_t,v_t] = one_dof_system_analytical_solver(m,c,k,time_span,x_0,xdot_0);

%% Solving Numerically
clc
clear all
close all

%system parameters
%mass    
m = 750;
%spring stiffness
k = 50000;
%damping
c = 1000;
%time span
time_span = [0:0.01:5];
%displacement initial conditions
x_0 = 0.01;
%velocity initial conditions
xdot_0 = 0;

%initial conditions vector
w0 = [x_0;xdot_0];

%numerical solution using ode45
%results give the state space variables (displacement and velocity) for each second of the simulation time 
[time results] = ode45(@(time,w)state_space_fun(time,w,m,k,c),time_span,w0);

%the displacment values
x_t = results(:,1)';
%the velocity values
v_t = results(:,2)';


%plotting the curve
figure(1)
hold on
plot(time,results(:,1),'-*','color','k')
plot(time, results(:,2),'-*','color','r')


%% Solving symbolically
clear all
close all
clc 

%system parameters
%mass in kgs
m = 750;

%spring stiffness in N/m
k = 50000;

%damping coefficient in N-s/m
c = 0; %no damping present

%time range
time = [0:0.01:2];

%initial conditions of the system
%initial displacement of the mass
x_0 = 0.01; 
%initial velocity of the mass
x_dot_0 = 0.2;

%defining symbolic expressions for time and displacement
%defining for time, the independent variable
syms t;

%defining displacement system which is a function of time
x = symfun(str2sym('x(t)'),t);

%defining the first differential (velocity function)
x_dot = diff(x,1);

%defining the second differential of x
x_dot_dot = diff(x,2);

%defining the governing ODE equation of motion
eom = m*x_dot_dot + c*x_dot + k*x;

%solving the ODE
x = dsolve(eom == 0, x(0) == x_0, x_dot(0) == x_dot_0, t);
%the displacement function has been now established


%defining the first differential of the displacment function
v = diff(x,1);

%finding amplitude
%finding the displacement values at all the times in the specified time
%range

x_values = double(subs(x,t,time)); %the values obtained are double (decimal values with 16 bits)

%amplitude of the motion
amp = max(x_values);

%time period
%finding the peak and peak location of the max displacement values
[x_value_peaks locations] = findpeaks(x_values);

%the time values at those peak locations
for i = 1:length(locations)
    time_peaks(i) = time(locations(i));
end

time_period = time_peaks(2) - time_peaks(1);

%frequency
freq = 1/time_period;
%angular frequency
omega = 2*pi*freq;