clear all
clc
data = load('torneira3.txt');
y = data(:,1);
u = data(:,2);

%Amostragem
Ts = 1;
theta = 0;
t = (1:1:140);

y0 = 1000;

ya = y(18:end);
ya = ya - 16;
ua = u(18:end);
for i = 1:123
    if i < 2
        up(i) = 1600;
    else
        up(i) = 3600;
    end
end
up = up - 1600;

ya = ya';
ya = ya - 1000;
ta = t(1:123);
figure(1); 
plot(ta, ya);

%Parametros
K1 = (mean(y(end-20:end)) - mean(y(1:20)))/(up(end) - up(1));

%resp. complementar:
w = log (abs(1 - ya./(K1*up)));
%figure(2); plot(ta, w); xlabel('t (s)'); ylabel('ln(y(t)/(K*u(t)))');

coef = polyfit(ta(2:30),w(2:30),1);

tau = -1/coef(1);

v = log(abs(exp(coef(2))*exp(-(ta)./tau) - (1 - ya./(K1*up))));
coef2 = polyfit(t(2:5),v(2:5),1);
figure(2);  
plot(ta, v); 
xlabel('t (s)'); 
ylabel('v(t)');
hold on; 
plot(ta, coef2(1)*ta + coef2(2), 'm-.', 'LineWidth', 2); %axis([0 18 -8 2]);
tau2 = -1/coef2(1);



G = tf(K1, [tau*tau2  tau+tau2  1], 'ioDelay', theta);
y2 = lsim(G, up, ta);

figure(1);  
hold on; 
plot(ta, y2, 'LineWidth',2); 
xlabel('t (s)'); ylabel('y(t)');

%validacao com outros dados
data = load('torneira4.txt');
y = data(:,1);
u = data(:,2);
ya = y(12:end);
ya = ya - 1015;
ta = ta(1:119);
y2 = y2(1:119);
figure(3); plot(ta, ya);
figure(3);  
hold on; 
plot(ta, y2, 'LineWidth',2); 
xlabel('t (s)'); ylabel('y(t)');