%Create VCM Plant Model
%Note:  This model is from "Design and testing of track-following
%controllers for dual-state servo systems with PZT actuated suspensions" by
%Li and Horowitz, Microsystem Technologies, 2002

%The uncertainty model is generated as follows:  
%1.)10% uncertainty in each natural frequency
%2.)20% uncertainty in each damping ratio
%3.)Multiplicative uncertainty to capture HF dynamics

%Build uncertain atoms
wv1 = ureal('wv1',135,'Percentage',10);
wv2 = ureal('wv2',5500,'Percentage',10);
wv3 = ureal('wv3',8640,'Percentage',10);
wv41 = ureal('wv41',7300,'Percentage',10);
wv42 = ureal('wv42',7650,'Percentage',10);
dv1 = ureal('dv1',0.1,'Percentage',20);
dv2 = ureal('dv2',0.03,'Percentage',20);
dv3 = ureal('dv3',0.05,'Percentage',20);
dv41 = ureal('dv41',0.03,'Percentage',20);
dv42 = ureal('dv42',0.015,'Percentage',20);
uvcm = ultidyn('uvcm',[1,1]);
Wvcm = makeweight(1e-6,5000,3);

%Construct uncertain plant
Gv = 10;  %DC Gain
Gv1 = tf((2*pi*wv1)^2,[1 2*dv1*2*pi*wv1 (2*pi*wv1)^2]);
Gv2 = tf((2*pi*wv2)^2,[1 2*dv2*2*pi*wv2 (2*pi*wv2)^2]);
Gv3 = tf((2*pi*wv3)^2,[1 2*dv3*2*pi*wv3 (2*pi*wv3)^2]);
Gv4 = wv41^2/wv42^2*tf([1 2*dv42*2*pi*wv42 (2*pi*wv42)^2],[1 2*dv41*2*pi*wv41 (2*pi*wv41)^2]);
VCM = Gv*Gv1*Gv2*Gv3*Gv4*(1+Wvcm*uvcm);

wp1 = ureal('wp1',8460,'Percentage',10);
wp21 = ureal('wp21',5500,'Percentage',10);
wp22 = ureal('wp22',5650,'Percentage',10);
wp41 = ureal('wp41',8070,'Percentage',10);
wp42 = ureal('wp42',8250,'Percentage',10);
wp51 = ureal('wp51',10650,'Percentage',10); 
wp52 = ureal('wp52',10530,'Percentage',10); 
dp1 = ureal('dp1',0.01,'Percentage',20);
dp21 = ureal('dp21',0.03,'Percentage',20);
dp22 = ureal('dp22',0.03,'Percentage',20);
dp41 = ureal('dp41',0.015,'Percentage',20);
dp42 = ureal('dp42',0.02,'Percentage',20);
dp51 = ureal('dp51',0.01,'Percentage',20);
dp52 = ureal('dp52',0.015','Percentage',20);
upzt = ultidyn('upzt',[1,1]);
Wpzt = makeweight(1e-6,8000,3);

Gp = 0.1;  %DC gain
Gp1 = tf((2*pi*wp1)^2,[1 2*dp1*2*pi*wp1 (2*pi*wp1)^2]);
Gp2 = wp21^2/wp22^2*tf([1 2*dp22*2*pi*wp22 (2*pi*wp22)^2],[1 2*dp21*2*pi*wp21 (2*pi*wp21)^2]);
Gp3 = Gv4;  %This mode is coupled between VCM and PZT
Gp4 = wp41^2/wp42^2*tf([1 2*dp42*2*pi*wp42 (2*pi*wp42)^2],[1 2*dp41*2*pi*wp41 (2*pi*wp41)^2]);
Gp5 = wp51^2/wp52^2*tf([1 2*dp52*2*pi*wp52 (2*pi*wp52)^2],[1 2*dp51*2*pi*wp51 (2*pi*wp51)^2]);
PZT = Gp*Gp1*Gp2*Gp3*Gp4*Gp5*(1+Wpzt*upzt);