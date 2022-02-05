close all
clear all
clc

load('HDD_freqresp.mat');

%% q3a
s = tf("s");
sampling_freq = 50000;
delay = exp(-1/2/sampling_freq * s); %approximated delay
Wc = 1000 * 2 * pi;
PM = 40;
sys = HDD_freqresp;
%In the bode plot, we found 2 notches need to be anti-notched
notch1 = notch(12.2, 183, 834);
notch2 = notch(20, 2100, 34400);

G = HDD_freqresp * delay;
[~, phase] = bode(G * notch1 * notch2, Wc); %after eliminating the notch, we use lead compensator to tune it

ang = -180+PM-phase; %how much need to compensate

C = lead(ang,Wc);
G_after = C * G * notch1 * notch2;
[mag, ~] = bode(G_after, Wc);
K = 1/mag;
figure;
bode(K * G_after, sys)
figure;
margin(K * G_after)

%% q3b

figure;
bodemag(feedback(K * G_after, 1), 1 - feedback(K * G_after, 1))%sensitivity function
legend('Complementary Sensitivity','Sensitivity','Location','SouthEast')

[T_peak,T_freq_peak] = getPeakGain(feedback(K * G_after, 1));
[S_peak,S_freq_peak] = getPeakGain(1 - feedback(K * G_after, 1));
T_db_peak = 20 * log10(T_peak)
T_freq_peak
S_db_peak = 20 * log10(S_peak)
S_freq_peak

%% q3c
% K * G_after is a frequency-response model
omeg = logspace(2, 6); 
approx = fitfrd(K * G_after, 8); %approximation want to fit
approxg = frd(approx, omeg); % change to frequency response model

figure;
bode(K * G_after,'r-',approxg,'b-')
figure;
step(feedback(approx, 1))
