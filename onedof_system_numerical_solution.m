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