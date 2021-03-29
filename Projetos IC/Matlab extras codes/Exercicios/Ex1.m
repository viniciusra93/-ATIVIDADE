clc
close all
clear all

%% Escolha parâmetros para essa FT   
K = 10; 
Teta = 100;
tau = 50;
Ts = tau/10; 

G = tf(K, [tau 1],'ioDelay', Teta); %FT


%% sinal PRBS de 300 amostras. 
Ur = prbs(300,6,1);
Ur = Ur';
figure(1)
stairs(Ur);
axis([0 300 -1 2]);

%% Simulação
t = [0:Ts:(299*Ts)];
y = lsim(G, Ur, t);
figure(2);
stairs(t, y);

%% Atraso puro de tempo via função de correlação cruzada (FCC).
lu = length(Ur); 
figure(3);
[t,r,l,B]=myccf2([y Ur],lu,1,1,'k');
axis([-10 40 -0.5 0.5])
xlabel('Atraso');
title('Função de Correlação Cruzada');

%% Mínimos quadrados (MQ) para estimar os demais parâmetros da FT.

Psi = [y(1:lu-1), Ur(1:lu-1)];
theta = (Psi' * Psi) \ Psi' * y(2:lu);

tau_hat = - Ts / (theta(1) - 1);
K_hat = (tau_hat * theta(2)) / Ts;

disp('Constante de tempo: ');
disp(tau_hat);
disp('Ganho: ');
disp(K_hat);

%% plot

figure(4);
G_hat = tf(K_hat,[tau_hat, 1],'ioDelay',100);
step(G_hat);
hold on
step(G);
legend('G_hat','G')
