%This function designs a lead (or lag) compensator giving a specified
%amount of phase lead (negative for lag) at a specific frequency.  Note
%that the maximum frequency of a lead compensator is <90 degrees.
%Usage:  Clead = lead(angle,frequency).  Angle is in degrees and frequency
%is in rad/s.
function Clead = lead(angle,freq)
alpha = (1+sind(angle))/(1-sind(angle));
z = freq/sqrt(alpha);
p = alpha*z;
Clead = tf([1 z],[1 p]);