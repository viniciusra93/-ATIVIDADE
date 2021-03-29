clc 
clear
%Sinal u:

mu = 0;
sigma = 1;

e = sigma.*randn(1,10003) + mu;

u = zeros(1,6);

for k = 4:9
    u(k-3) = 0.9*e(k-1) + 0.8*e(k-2) + 0.7*e(k-3) + e(k);
end


lu=length(u);

[t,ruu,l,B1]=myccf2([u(1:lu)' u(1:lu)'],5,0,1,'k');

figure(1)
set(gca,'FontSize',18)
plot([0 20],[l l],'k--',[0 20],[-l -l],'k--');
axis([-0.5 6 -1.1 1.1]);
hold on
stem(t,ruu,'k');
hold off
xlabel('atraso');
title('(a)');