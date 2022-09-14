clc()
% x0 is inital point
x0 = 1;

% Polynomial is the coefficients of a regular polynomial.
% [3 2 1] == 3 + 2x + x^2
polynomial = [3 2 1];


p = polynomial(end);
q = 0;
for i = (length(polynomial)-1):-1:1
    q = p + x0 * q;
    p = polynomial(i) + x0 * p;
end

disp("P(x0) = " + p)
disp("P'(x0) = " + q)
