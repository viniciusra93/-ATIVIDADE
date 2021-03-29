%Vinicius -- feito com a rotina do aguirre

close all;
clear;
clc;

H = tf([0 0 1],[0 1000 1]);
b = 12;
N = 10000;

%Tb = 1
u = prbs(N, b, 1);

figure(1)
lsim(H, u, 0:1:N-1);
xlim([0 N])
axis([0 N -0.5 1.5]);
xlabel('amostras');
title('Tb = 1')

%Tb = 100
u = prbs(N, b, 100);

figure(2)
lsim(H, u, 0:1:N-1);
xlim([0 N])
axis([0 N -0.5 1.5]);
xlabel('amostras');
title('Tb = 100')

%Tb = 1000

u = prbs(N, b, 1000);

figure(3)
lsim(H, u, 0:1:N-1);
xlim([0 N])
axis([0 N -0.5 1.5]);
xlabel('amostras');
title('Tb = 1000')


%Tb = 10000

u = prbs(N, b, 10000);

figure(4)
lsim(H, u, 0:1:N-1);
xlim([0 N])
axis([0 N -0.5 1.5]);
xlabel('amostras');
title('Tb = 10000')




