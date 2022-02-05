close all;
clear all;
clc;

num = [100];
den = [1 11 10 0];
G_before = tf(num, den);
[~,phase] = bode(G_before,5);

ang = -180+60-phase; %how much need to compensate
f = 5;
C = lead(ang,f);
G_after = C * G_before;

[mag,~] = bode(G_after,5);
K = 1/mag;

figure;
margin(K * G_after)

sys1 = feedback(G_before,1);
sys2 = feedback(K * G_after,1);
figure;
step(sys1, sys2, 5)
legend('Without Lead','With Lead','Location','SouthEast')
