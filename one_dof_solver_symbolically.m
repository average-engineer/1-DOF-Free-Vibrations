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