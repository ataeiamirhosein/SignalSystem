clc
clear all
close all

%% cration of the signal

dt=0.0001; % time descrtitization step S
T_width=10;
N=T_width/dt;
t=[0:N-1]*dt;

f1=5;
f2=20;
A1=3;
A2=1;

y=A1*sin(2*pi*f1*t)+A2*sin(2*pi*f2*t);

figure(1);
plot(t,y),grid on,xlabel('time [s]');
title('signal1'), axis([0 2 -5 5]);

%% spectrum 

df=1/T_width;
f=[-N/2:N/2-1]*df;
Y=fftshift(fft(y))/N;

figure(2)
plot(f,abs(Y),'m'),grid on, xlabel('frequency [Hz]');
title('signal spectrum')
axis([-50 50 0 2])

%% sampeling

undersampeling=200;
f_sampeling=(1/dt)/undersampeling

t_s=t(1:undersampeling:end);
y_s=y(1:undersampeling:end);

y_s_bis=zeros(size(y));
y_s_bis(1:undersampeling:end)=y_s;

figure(3)
plot(t,y), grid on, xlabel('time [s]'), hold on
stem(t_s,y_s,'r');
axis([0 0.2 -4 4])
pause

%%spectrum of the sampel signal

Y_s=fftshift(fft(y_s_bis)) / (N/undersampeling);

figure(4)
plot(f,abs(Y_s),'m'),grid on, xlabel('frequency [Hz]');
title('sampel signal spectrum')
axis([-500 500 0 2])

Y_r=Y_s .* rect(f/f_sampeling);

figure(5)
plot(f,abs(Y_r),'m'),grid on, xlabel('frequency [Hz]');
title('sampel signal spectrum'), hold on
plot(f,rect(f/f_sampeling),'c')

y_r=ifft(ifftshift(Y_r))*N;

figure(6);
plot(t,y,'k:'),axis([0 0.2 -4 4]),grid on ,hold on
plot(t,y_r,'b')

function Y=rect(f)
Y=0.5*(sign(f+0.5)-sign(f-0.5));
end