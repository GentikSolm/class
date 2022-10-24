clc
% q6
fx = @(x) x.^3 - 2;
fpx = @(x) 3 * x.^2;
tol = eps('single');
x0 = 10;
est = Newtons(fx, fpx, tol, x0);
disp("F(x) = " + func2str(fx))
disp("F(x0) = " + x0)
disp("With tolerance of " + tol)
disp("Final estimation: " + est)

clc
% q7
fx = @(x) x.^3 - 2;
tol = eps('single');
x0 = 10;
est = Secant(fx, tol, x0);
disp("F(x) = " + func2str(fx))
disp("F(x0) = " + x0)
disp("With tolerance of " + tol)
disp("Final estimation: " + est)
disp("We can see the secant method uses many more iterations than the newton method, at 1778 iterations vs only 10 for newtons")