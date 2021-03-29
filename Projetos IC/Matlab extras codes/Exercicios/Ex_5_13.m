clc
close all
clear all

%% data

%BFG33 = load('BFG33.DAT');

BFG44 = load('BFG44.DAT');
t = BFG44(:,1);
U = BFG44(:,2);
y = BFG44(:,3);

% t = BFG33(:,1);
% U = BFG33(:,2);
% y = BFG33(:,3);



Ts = t(2)-t(1);

lu = length(U);

figure(1)
subplot(2,1,1);
plot(t, U);
title('U(k)');
subplot(2,1,2);
plot(t,y);
title('y(k)');

%% FCC
figure(2)
myccf2([y U],lu,1,1,'k');
title('FCC');

%% ARX

Psi = [y(1:lu-1) U(1:lu-1)]; %N x 2
Y = y(2:lu); %N x 1

%% MQQ

theta = (Psi' * Psi) \ Psi' * y(2:lu);

tau_hat = - Ts / (theta(1) - 1);
K_hat = (tau_hat * theta(2)) / Ts;

disp('Constante de tempo: ');
disp(tau_hat);
disp('Ganho: ');
disp(K_hat);

%% Comparação com H1

G = tf(K_hat,[tau_hat 1]);
%H1 = tf(1.338*exp(-1.9),[3.5802 3.406 1]);
H2 = tf(0.0182*exp(-4.7),[1 0.2304 0.052])


[y_hat, t_hat] = lsim(G, U, t);
%[y_h1, t_h1] = lsim(H1, U, t);
[y_h2, t_h2] = lsim(H2, U, t);

figure(3);
%plot(t_h1, y_h1, 'r')
plot(t_h2,t_h2,'r')
hold on;
plot(t_hat, y_hat)
leg = legend({'y(k)';'$\hat{y}(k)$';'$\hat{y}_{step}(k)$'});
set(leg,'Interpreter','latex');






