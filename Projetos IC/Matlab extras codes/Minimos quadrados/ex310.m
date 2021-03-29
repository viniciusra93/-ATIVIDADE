clc 
clear
%Entradas:
t = (-5:0.01:5)';
%aletória:

u1 = randn(length(t),1)';

%impulso:

u2 = t==0;

%Plot Entradas

figure(1)
subplot(211)
plot(t,u1)
title('Aleatório');
subplot(212)
plot(t, u2)
title('Impulso');

% Saídas:
H = tf(1, [1 0.2 0.8], 'ioDelay', 0);



figure(2)
subplot(211)
lsim(H, u1, t);
title('Aleatório');
subplot(212)
lsim(H, u2, t);
title('Impulso');
