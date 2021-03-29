clc
close all
clear all

%% Item a)
%polos 
p1 = -0.5;
p2 = -0.7;

%zeros
z = 0.5;

%Parâmetros
b1 = -2*z;
b2 = z^2;
a1 = -(p1 + p2);
a2 = p1 * p2;
Ts = 1;

num = [0 b1 b2];
den = [1 a1 a2];

H = tf(num,den,Ts, 'variable', 'z^-1') %FT

%estabilidade:
% figure;
% pzplot(H)
% h = findobj(gca, 'type', 'line');
% set(h, 'markersize', 9)
% text(real(roots(num)) - 0.1, imag(roots(num)) + 0.1, 'Zero')
% text(real(roots(den)) - 0.1, imag(roots(den)) + 0.1, 'Pole')
% xlabel('Real') 
% ylabel('Imaginário')  
% axis equal

% sinal PRBS de 189 amostras. 

N = 189;
n = 6;
m = 1;

U = prbs(N,n,m);
U = U';
% figure;
% stairs(U);
% axis([0 N -1 2]);

% Simulação y

t = [0:Ts:(N-1*Ts)];
y = lsim(H, U, t);
figure;
stairs(t, y);
axis([-1 180 -4 4]);

% Sinal ruidoso
sigma_y = std(y);
sigma_e = sigma_y/10^(12/20);
e = sigma_e.*randn(N,1);

Ym = zeros(N,1);
Ym(1:2) = e(1:2);

for k=3:N
    Ym(k)= -a1*Ym(k-1) - a2*Ym(k-2) + b1*U(k-1) + b2*U(k-2) + e(k);
end
% 
%figure;
% stairs(t, Ym);
% axis([-1 180 -4 4]);

%Simulação dos dois sinais 

figure;
stairs(t,[y,Ym]);
legend('Y','Ym');
axis([-1 180 -4 4]);

%% Itens B e C

%Degrau
U2 = ones(N,1);
o = 2;

% SEM RUIDO
[h_hat, Psi, Y] = myarx(y,U,o); %ARX

%parâmetros
disp('h_hat: ');
disp(h_hat);


%simulações
y_hat_pf = simulacao1pf(y,U2,h_hat,N);
y_hat_livre = simulacaoLivre(y,U2,h_hat,N);
figure;
stairs(t,[y y_hat_pf, y_hat_livre]);
legend('y','Um passo a frente', 'livre');
axis([-1 190 -4 4]);

% COM RUÍDO

[hm_hat, Psi, Y] = myarx(Ym,U,o); %ARX

%parâmetros
disp('hm_hat: ');
disp(hm_hat);

%simulações
ym_hat_pf = simulacao1pf(Ym,U2,hm_hat,N);
ym_hat_livre = simulacaoLivre(Ym,U2,hm_hat,N);
figure;
stairs(t,[Ym ym_hat_pf ym_hat_livre]);
legend('Ym','Um passo a frente','Livre');
axis([-1 190 -4 4]);


%% Item D
% 5db

sigma_e5 = sigma_y/10^(5/20);
e5 = sigma_e5.*randn(N,1);

Ym5 = zeros(N,1);
Ym5(1:2) = e5(1:2);

for k=3:N
    Ym5(k)= -a1*Ym5(k-1) - a2*Ym5(k-2) + b1*U(k-1) + b2*U(k-2) + e5(k);
end
% 
%figure;
% stairs(t, Ym5);
% axis([-1 180 -4 4]);

[hm5_hat, Psi, Y] = myarx(Ym5,U,o); %ARX

%parâmetros
disp('hm5db_hat: ');
disp(hm5_hat);


%simulações
ym5_hat_pf = simulacao1pf(Ym5,U2,hm5_hat,N);
ym5_hat_livre = simulacaoLivre(Ym5,U2,hm5_hat,N);
figure;
stairs(t,[Ym5 ym5_hat_pf ym5_hat_livre]);
legend('Ym5db','Um passo a frente','Livre');
axis([-1 190 -4 4]);


% 10db

sigma_e10 = sigma_y/10^(10/20);
e10 = sigma_e10.*randn(N,1);

Ym10 = zeros(N,1);
Ym10(1:2) = e10(1:2);

for k=3:N
    Ym10(k)= -a1*Ym10(k-1) - a2*Ym10(k-2) + b1*U(k-1) + b2*U(k-2) + e10(k);
end
% 
%figure;
% stairs(t, Ym10);
% axis([-1 180 -4 4]);

[hm10_hat, Psi, Y] = myarx(Ym10,U,o); %ARX

%parâmetros
disp('hm10db_hat: ');
disp(hm10_hat);


%simulações
ym10_hat_pf = simulacao1pf(Ym10,U2,hm10_hat,N);
ym10_hat_livre = simulacaoLivre(Ym10,U2,hm10_hat,N);
figure;
stairs(t,[Ym10 ym10_hat_pf ym10_hat_livre]);
legend('Ym10db','Um passo a frente','Livre');
axis([-1 190 -4 4]);

% 15db

sigma_e15 = sigma_y/10^(15/20);
e15 = sigma_e15.*randn(N,1);

Ym15 = zeros(N,1);
Ym15(1:2) = e15(1:2);

for k=3:N
    Ym15(k)= -a1*Ym15(k-1) - a2*Ym15(k-2) + b1*U(k-1) + b2*U(k-2) + e15(k);
end
% 
%figure;
% stairs(t, Ym15);
% axis([-1 180 -4 4]);

[hm15_hat, Psi, Y] = myarx(Ym15,U,o); %ARX

%parâmetros
disp('hm15db_hat: ');
disp(hm15_hat);


%simulações
ym15_hat_pf = simulacao1pf(Ym15,U2,hm15_hat,N);
ym15_hat_livre = simulacaoLivre(Ym15,U2,hm15_hat,N);
figure;
stairs(t,[Ym15 ym15_hat_pf ym15_hat_livre]);
legend('Ym15db','Um passo a frente','Livre');
axis([-1 190 -4 4]);

% 20db

sigma_e20 = sigma_y/10^(20/20);
e20 = sigma_e20.*randn(N,1);

Ym20 = zeros(N,1);
Ym20(1:2) = e(1:2);

for k=3:N
    Ym20(k)= -a1*Ym20(k-1) - a2*Ym20(k-2) + b1*U(k-1) + b2*U(k-2) + e20(k);
end
% 
%figure;
% stairs(t, Ym20);
% axis([-1 180 -4 4]);

[hm20_hat, Psi, Y] = myarx(Ym20,U,o); %ARX

%parâmetros
disp('hm20db_hat: ');
disp(hm20_hat);


%simulações
ym20_hat_pf = simulacao1pf(Ym20,U2,hm20_hat,N);
ym20_hat_livre = simulacaoLivre(Ym20,U2,hm20_hat,N);
figure;
stairs(t,[Ym20 ym20_hat_pf ym20_hat_livre]);
legend('Ym20db','Um passo a frente','Livre');
axis([-1 190 -4 4]);


%% Item E

% PRIMEIRA ORDEM;

num1 = [0 b1];
den1 = [1 a1];

H1 = tf(num1,den1,Ts, 'variable', 'z^-1') %FT

y1 = lsim(H1, U, t);
figure;
stairs(t, y1);
%axis([-1 180 -4 4]);

% Sinal ruidoso
sigma_y1 = std(y1);
sigma_e1 = sigma_y1/10^(12/20);
e1 = sigma_e1.*randn(N,1);

Ym1 = zeros(N,1);
Ym1(1:2) = e1(1:2);

for k=2:N
    Ym1(k)= -a1*Ym1(k-1) + b1*U(k-1) + e1(k);
end
% 
%figure;
% stairs(t, Ym1);
% axis([-1 180 -4 4]);



% SEM RUIDO
[h1_hat, Psi, Y1] = myarx(y1,U,1); %ARX

figure;
pzplot(H1)
xlabel('Real') 
ylabel('Imaginário')  
axis equal

%parâmetros
disp('h1_hat: ');
disp(h1_hat);


%simulações
y1_hat_pf = simulacao1pf(y1,U2,h1_hat,N);
y1_hat_livre = simulacaoLivreo1(y1,U2,h1_hat,N);
figure;
stairs(t,[y1 y1_hat_pf y1_hat_livre]);
legend('y1','Um passo a frente','Livre');
%axis([-1 190 -8 8]);

% COM RUÍDO

[hm1_hat, Psi, Y] = myarx(Ym1,U,1); %ARX

%parâmetros
disp('hm1_hat: ');
disp(hm1_hat);

%simulações
ym1_hat_pf = simulacao1pf(Ym1,U2,hm1_hat,N);
ym1_hat_livre = simulacaoLivreo1(Ym1,U2,hm1_hat,N);
figure;
stairs(t,[Ym1 ym1_hat_pf ym1_hat_livre]);
legend('Ym1','Um passo a frente','Livre');
%axis([-1 190 -8 8]);


% %TERCEIRA ORDEM
p3 = -0.1;
a3 = p1*p2*p3;
b3 = p1+p2+p3;
num1 = [0 b1 b2 b3];
den1 = [1 a1 a2 a3];

H3 = tf(num1,den1,Ts, 'variable', 'z^-1') %FT

figure;
pzplot(H3)
xlabel('Real') 
ylabel('Imaginário')  
axis equal

y3 = lsim(H3, U, t);
figure;
stairs(t, y3);
%axis([-1 180 -4 4]);

% Sinal ruidoso
sigma_y3 = std(y3);
sigma_e3 = sigma_y3/10^(12/20);
e3 = sigma_e3.*randn(N,1);

Ym3 = zeros(N,1);
Ym3(1:4) = e3(1:4);

for k=4:N 
    Ym3(k)= -a1*Ym3(k-1) - a2*Ym3(k-2) - a3*Ym3(k-3) +  b1*U(k-3) + b2*U(k-2) + b3*U(k-1) + e3(k);
end
% 
%figure;
% stairs(t, Ym1);
% axis([-1 180 -4 4]);



% SEM RUIDO
[h3_hat, Psi, Y1] = myarx(y3,U,3); %ARX

%parâmetros
disp('h3_hat: ');
disp(h3_hat);


%simulações
y3_hat_pf = simulacao1pf(y3,U2,h3_hat,N);
y3_hat_livre = simulacaoLivreo3(y3,U2,h3_hat,N);
figure;
stairs(t,[y3 y3_hat_pf y3_hat_livre]);
legend('y1','Um passo a frente','Livre');
%axis([-1 190 -8 8]);

% COM RUÍDO

[hm3_hat, Psi, Y] = myarx(Ym3,U,3); %ARX

%parâmetros
disp('hm3_hat: ');
disp(hm3_hat);

%simulações
ym3_hat_pf = simulacao1pf(Ym3,U2,hm3_hat,N);
ym3_hat_livre = simulacaoLivreo3(Ym1,U2,hm3_hat,N);
figure;
stairs(t,[Ym3 ym3_hat_livre]);
legend('Ym3','Livre');
figure;
stairs(t,[Ym3 ym3_hat_pf]);
legend('Ym3','Um passo a frente');
%axis([-1 190 -8 8]);
