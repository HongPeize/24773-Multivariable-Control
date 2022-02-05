close all;
clear all;
clc;

num = [100];
den = [1 11 10 0];
G = tf(num,den);
[A,B,C,D] = tf2ss(num,den);
sys = ss(A,B,C,D);
state_poles = [-0.665+1.3i -0.665-1.3i -50.4];
K = place(A, B, state_poles);
observer_poles = [-55 -60 -65];
L = place(A', C', observer_poles)';
rsys = reg(sys, K, L);
sys = feedback(G * rsys, -1);
initial(sys,[1; 0; 0; 0; 0; 0])