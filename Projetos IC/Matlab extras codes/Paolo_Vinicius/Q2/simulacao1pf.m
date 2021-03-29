function  yEst =  simulacao1pf(y,u,h,n)
    o = size(h,1)/2;
    yEst = zeros(n,1);
    for i = 1:o
        yEst(i) = y(i);
    end
    for i = o+1:n
        v = [y(i-1:-1:i-o); u(i-1:-1:i-o)]';
        yEst(i) = v*h;
    end
    
end
