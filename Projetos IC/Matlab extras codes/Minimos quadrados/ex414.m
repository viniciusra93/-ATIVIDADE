%Vinicius -- feito com a rotina do aguirre
clc
close all
clear all
N = 700;
b = 6;
j = 1;


for i = 1:3
    m = i;
    y = prbs(N,b,m);
    figure(j);
    stairs(y); axis([0 N -1 2]);
    hold off
    figure(j+1);
    [t,r,l,B]=myccf2([y'],350,1,1,'k');
    j = j+2;
end