%This function generates notch (or anti-notch) filters with a specified
%width and depth at a specific frequency
%Usage:  Cnotch = notch(depth,width,frequency).  Depth is in dB, with a
%positive depth indicating a notch and negative an anti-notch. 
%Frequencies are in rad/s.  Width is the width of the notch 3 dB from the 
%peak.
function Cnotch = notch(depth,width,freq)
Cnotch = tf([1 width freq^2],[1 10^(depth/20)*width freq^2]);
