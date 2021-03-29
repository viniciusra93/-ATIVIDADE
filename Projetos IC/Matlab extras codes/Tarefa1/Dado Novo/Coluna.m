%close all; 
clear all
clc

%load:
data = load('distill2.dat');
Ts = 10/250;
%y e u
t = data(2:end,1);
y = data(2:end,6);

%plot 1
figure(1)
plot(t,y);
xlabel('t (s)'); ylabel('y(t)');
%Acha os picos da função plotada a partir do zero ( Neste Caso foi 28):
Picos = findpeaks(y);

%Parâmetros:

K = 11.8;
Wn = 89;
Zeta = 0.6/length(Picos); 

Hs = tf(K*Wn^2, [1 2*Wn*Zeta Wn^2]);
u = ones(length(t),1)*10^4;
u(1) = 0;
u(2) = 1.12*10^4;
figure(2)
G = lsim(Hs, u',t )-Ts;
plot(G,'r--');
hold on
plot(y)

xlabel('t (s)'); ylabel('y(t)');