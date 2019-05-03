%3.a
%-------------------------------
Vin = 28;
Vout = 15;
R = 3;
L = 50*10^(-6);
C = 500*10^(-6);
Vm = 4;
R1 = 1*1000;
R2 = 2*1000;
s = tf('s');

wo = 1/(L*C);
Q = R*(C/L)^(0.5);
H = R2/(R1+R2);
Gvd = Vin*(1/(1+s/(Q*wo) + (s/wo)^2));
T = Vin*((Vin*H)/Vm)/(1 + s/(Q*wo) + (s/wo)^2);


opts = bodeoptions('cstprefs');
opts.FreqUnits = 'Hz';
figure(1)
bode(T,opts)

figure(2)
step(T)

figure(3)
margin(T)
[Gm,Pm,Wcg,Wcp] = margin(T);
Wcg = Wcg/(2*pi);
Wcp = Wcp/(2*pi);

%3.b
%------------------------
wi = realp('wi',0);
Gc = wi/s;
Y = AnalysisPoint('y');
T = feedback(Y*Gvd*(1/Vm)*Gc,H);
T.InputName = 'r';
T.OutputName = 'y';

req1 = TuningGoal.Gain('r','y',1);
req2 = TuningGoal.Margins('y',1,30);
[a,b]=systune(T,req1,req1);
figure(4)
margin(a)
figure(5)
step(a)

