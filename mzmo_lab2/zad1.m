%1.a
%-----------------------
s = tf('s');
H = 10/(s^2 + 2*s +10);
figure(1)
step(H)

%-----------------------

%1.b
%-----------------------
t = 0:0.01:5;
y = 2*sin(3*t);
figure(2)
lsim(H,y,t)
figure(3)
bode(H)
figure(4)
nyquist(H)
figure(5)
H1 = zeros(201);
i=1;
for omega=-10:0.1:10
    H1(i) = 10/((1i*omega).^2+2*1i*omega+10);
    i=i+1;
end
plot(H1);





