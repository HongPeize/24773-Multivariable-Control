close all
clear all
clc

num = [50 100];
den = [0.2 3 10 0];
G = tf(num, den);

figure;
bode(G), grid
figure;
margin(G)
figure;
nyquist1(G)
figure;
step(feedback(G,1))