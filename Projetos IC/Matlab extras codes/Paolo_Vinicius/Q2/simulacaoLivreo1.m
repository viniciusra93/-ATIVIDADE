%Simula m passoas a frente
function yEst = simulacaoLivreo1 (y, u, h, n)
    o = size(h,1)/2;
    yEst = zeros(n,1);
    for i = 1:o
        yEst(i) = y(i);
    end
    for i = o+1:n
        v = [yEst(i-1:-1:i-o); u(i-1:-1:i-o)]';
        yEst(i) = v*h;
    end
    
    y_sim = zeros(n, 1);
    
    for k = 3:n
        y_sim(k-1) = [yEst(k-1) u(k-1)] * h;
    end
    yEst = y_sim;
end
