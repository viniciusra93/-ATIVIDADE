%Vinicius -- feito com a rotina do aguirre

% O sistema N = 63 e n = 6
signal=prbs(63,6,1);

%Aumentando o número de amostras:
u = repmat(signal,1,3);

%u=u-0.5;
lu=length(u);

%plot
figure(1)
stairs(u);
axis([0 lu -0.5 1.5]);
xlabel('amostras');


%Autocorrelação
[t,ruu,l,B1]=myccf2([u(1:lu)' u(1:lu)'],lu,1,1,'k');


figure(2)
set(gca,'FontSize',18);
plot([-100 100],[l l],'k--',[-100 100],[-l -l],'k--');
axis([-100 100 -1.1 1.1]);
hold on
stem(t,ruu,'k');
hold off
xlabel('atraso');
title('Autocorrelação');



