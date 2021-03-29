clc;
clear all;
close all;

%% Carrega os Dados
x = load('dados_tarefa4.txt');
t = x(:,1)';
u = x(:,2)';
y = x(:,3)';
subplot(2,1,1)
plot(x(:,1),x(:,2))
title('u(t) Sinal Original')
xlabel('Tempo(s)')
subplot(2,1,2)
plot(x(:,1),x(:,3),'r')
title('y(t) Sinal Original')
xlabel('Tempo(s)')

%% Separa os Dados em Identificação e Validação

ini = find(t == 140);
fim = find(t == 200);


t_val = t(ini:fim);
t(ini:fim) = [];
t_id = t;

u_val = u(ini:fim);
u(ini:fim) = [];
u_id = u;

y_val = y(ini:fim);
y(ini:fim) = [];
y_id = y;

figure
subplot(2,1,1)
plot(t_id, u_id)
title('u(t) Parte de Identificação')
xlabel('Tempo(s)')
subplot(2,1,2)
plot(t_id,y_id,'r')
title('y(t) Parte de Identificação')
xlabel('Tempo(s)')

figure
subplot(2,1,1);
plot(t_val, u_val);
title('u(t) Parte de Validação')
xlabel('Tempo(s)')
subplot(2,1,2);
plot(t_val, y_val,'r');
title('y(t) Parte de Validação')
xlabel('Tempo(s)')

%% Nova amostragem dos dados
figure
[lag, corr] = myccf2(y',100);
title('Autocorrelação da saída')
[~,pos_min] = min(corr);
% Para pos_min ficar entre 10 e 20, precisa-se dividi-lo por 2, então os dadores serão
% decimados em 2 vezes
dec = 2;
t_id_dec = t_id(1:dec:end);
u_id_dec = u_id(1:dec:end);
y_id_dec = y_id(1:dec:end);

t_val = t_val(1:dec:end);
u_val = u_val(1:dec:end);
y_val = y_val(1:dec:end);

%% Verificação da correlação entre entrada e saída
figure
myccf2([u_id_dec' y_id_dec'],100);
title('Correlação entre entrada e saida')

%% Escolha da ordem do sistema com modelos ARX e AIC
for order = 1 : 8
    sys = arx([y_id_dec',u_id_dec'] ,[order,order,1]);
    akaike(order) = sys.Report.Fit.nAIC;
    fpe(order) = sys.Report.Fit.BIC;
end;

[~,order] = min(diff(akaike));
order = 3;
figure
plot(akaike);
title('Critério de informação de Akaike')
xlabel('Ordem do Modelo ARX')
figure
plot(fpe);
title('Critério de informação de Bayes')
xlabel('Ordem do Modelo ARX')

sys = arx([y_id_dec',u_id_dec'] ,[order,order,1]);


%% Método dos Mínimos Quadrados com a ordem encontrada para o modelo
for i = 0:order-1
        mat_MQ(:,i+1) = y_id_dec(order - i:end-i-1);
        mat_MQ(:,i+1+order) = u_id_dec(order - i:end-i-1);
end

y_MQ = y_id_dec(order + 1:end);
theta_MQ = inv(mat_MQ'*mat_MQ)*mat_MQ'*y_MQ';
y_MQ = mat_MQ*theta_MQ;

figure
plot(t_id_dec(order + 1:end),y_id_dec(order + 1:end))
hold on;
plot(t_id_dec(order + 1:end),y_MQ,'r--')
title('Estimativa do modelo na identificação');
legend('real', 'estimado')
xlabel('Tempo(s)')
%% Validação do Modelo
% 1 Passo a frente

for i = 0:order-1
        mat_MQ_1(:,i+1) = y_val(order - i:end-i-1);
        mat_MQ_1(:,i+1+order) = u_val(order - i:end-i-1);
end

y_MQ_1 = mat_MQ_1*theta_MQ;

figure;
plot(t_val(order + 1:end),y_val(order + 1:end),'b')
hold on;
plot(t_val(order + 1:end), y_MQ_1, 'r--')
legend;
title('Validação um passo a frente');
legend('real', 'estimado')
xlabel('Tempo(s)')

% CALCULO DO RMSE
error_MQ_1 = y_val(order + 1:end)' - y_MQ_1;
error_MQ_1_SQUARED = error_MQ_1.^2;
RMSE_MQ_1 = sqrt(mean(error_MQ_1_SQUARED));

figure;
myccf2(error_MQ_1, length(error_MQ_1));
title('FAC para erro um passo a frente')

% Validação Livre
y_MQ_livre(1:order) = y_val(1:order);

for i = order+1 : length(y_val)
    MQ_vector = [y_MQ_livre(i-1) y_MQ_livre(i-2) y_MQ_livre(i-3) u_val(i-1) u_val(i-2) u_val(i-3)];
    y_MQ_livre(i) = MQ_vector*theta_MQ;
end


figure;
plot(t_val(order + 1:end),y_val(order + 1:end),'b')
hold on;
plot(t_val(order + 1:end), y_MQ_livre(order + 1:end), 'r--')
legend;
title('Validação Livre');
legend('real', 'estimado')
xlabel('Tempo(s)')

% CALCULO DO RMSE
error_MQ_livre = y_val' - y_MQ_livre';
error_MQ_livre_SQUARED = error_MQ_livre.^2;
RMSE_MQ_livre = sqrt(mean(error_MQ_livre_SQUARED));

figure;
myccf2(error_MQ_livre, length(error_MQ_livre));
title('FAC para erro validação livre')