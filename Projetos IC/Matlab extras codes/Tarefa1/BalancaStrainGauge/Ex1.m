%close all; 
clear all; clc

%load:

Prato1 = load('DS100g_prato_1.txt');
Ts = 0.05;

%Nao h� atraso de tempo:
p_inicial = find(Prato1(:,1) == 0);


%y e t
y = Prato1(p_inicial:end,2);
t = Prato1(p_inicial:end,1);

%Acha os picos da fun��o plotada a partir do zero ( Neste Caso foi 69):
Picos = findpeaks(y);

%Par�metros:

K = 1/0.1;
Wn = 2*pi/0.1;
Zeta = 0.6/length(Picos); 

Hs = tf(K*Wn^2, [1 2*Wn*Zeta Wn^2]);

u = ones(length(t),1);
    

figure(1)
G = lsim(Hs*0.1, u', t)-Ts;
plot(G,'r');
hold on
plot(y)

xlabel('tempo'); ylabel('amplitude');

%Valida��o com prato 2

Prato2 = load('DS100g_prato_2.txt');
Ts = 0.05;

%Nao h� atraso de tempo:
p_inicial = find(Prato2(:,1) == 0);


%Labels do plot
y = Prato2(p_inicial:end,2);
t = Prato2(p_inicial:end,1);

%Acha os picos da fun��o plotada a partir do zero ( Neste Caso foi 69):
Picos = findpeaks(y);

%Par�metros:
Wn = 115; %REdefini��o dos parametros para tentativa de melhor ajuste
Zeta = 0.6/length(Picos); 

Hs = tf(K*Wn^2, [1 2*Wn*Zeta Wn^2]);

%Defini��o da entrada u
u = ones(length(t),1);

figure(2)
G = lsim(Hs*0.1, u', t)-Ts;
plot(G,'r');
hold on
plot(Prato2(p_inicial:end,2))

xlabel('tempo'); ylabel('amplitude');
 




