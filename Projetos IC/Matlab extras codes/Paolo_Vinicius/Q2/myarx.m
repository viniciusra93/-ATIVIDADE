% Estima um modelo ARX
% y -> sadia
% u -> entrada
% o -> ordem
function [h,A,Y] = myarx(y, u, o)
    n = size(y,1);
    A = zeros(n-o,2*o);
    Y = zeros(n-o,1);
    for i = (1+o):n
        Y(i) = y(i);
        A(i,:) = [y(i-1:-1:i-o); u(i-1:-1:i-o)]'; 
    end
    h = (A'*A)^(-1)*A'*Y;
end