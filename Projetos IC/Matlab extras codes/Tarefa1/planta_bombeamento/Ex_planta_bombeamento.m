clear all; 
clc; 
close all

planta = load('ENS_25.DAT');

Ts = 1.0440;
SP1 = 16.34;
SP2 = 17.05*1.012;
to =0;
tff = 1500;
TD = 100;

k=0;
% criacao do vetor de entrada U em degrau
for i = to:tff-1
	k = k + 1;
	if k < 2
	  u(k) = SP1;
	else 
	  u(k) = SP2;
    end
end

u = u';
u1 = u - SP1;
un = u1/(17.05-16.34);
t = (1:Ts:tff*Ts);
y = planta(:,2);
y = y(101:1600);

%Método das áreas:

%Definição dos parâmetros
K1 = (mean(y(end-20:end)) - mean(y(1:20)))/(u(end) - u(1));
y0 = 0.0750;
yn = y - y0;
yn = yn./(mean(y(end-20:end)) - mean(y(1:20)));

area = 0;
for i = 1:400
    area = area + Ts*(un(i)-yn(i));
end

tau1 = area;
theta1 = area - tau1;
G1a = tf(K1, [tau1 1], 'ioDelay', theta1);
y1 = lsim(G1a, u1, t) + y0;
plot(y1, 'linewidth', 4); xlabel('tempo'); ylabel('nivel');
hold on
plot(y);


%vdegrau negativo
planta = load('ENS_26.DAT');
y = planta(:,2);
y = y(101:1600);

k=0;
for i = to:tff-1
	k = k + 1;
	if k < 2
	  u(k) = SP2;
	else 
	  u(k) = SP1;
    end
end

u = u';
u1 = u - SP2;

y1 = lsim(G1a, u1, t) + 0.27;
figure(2);
plot(y1, 'linewidth', 2); xlabel('tempo'); ylabel('nivel');
hold on
plot(y);