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
disp(" ")

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
disp(" ")

% q8
fx = @(x) x*exp(-x);
fpx = @(x)  exp(-x)-x*exp(-x);
tol = eps('single');
x0 = .5;
est = Newtons(fx, fpx, tol, x0, 0, 2);
disp("F(x) = " + func2str(fx))
disp("F(x0) = " + x0)
disp("With tolerance of " + tol)
disp("Final estimation: " + est)
disp("Here we can see that Rn approaches 1 as the estimate gets closer to its target")
disp(" ")

fx = @(x) 2-exp(x);
fpx = @(x)  -exp(x);
tol = eps('single');
x0 = .5;
est = Newtons(fx, fpx, tol, x0, log(2), 2);
disp("F(x) = " + func2str(fx))
disp("F(x0) = " + x0)
disp("With tolerance of " + tol)
disp("Final estimation: " + est)
disp(" ")

fx = @(x) 2-exp(x);
fpx = @(x)  -exp(x);
tol = eps('single');
x0 = 1.5;
est = Newtons(fx, fpx, tol, x0, log(2), 2);
disp("F(x) = " + func2str(fx))
disp("F(x0) = " + x0)
disp("With tolerance of " + tol)
disp("Final estimation: " + est)
disp("Here we can see that the ratio fluxuates heavily when getting to values very close to zero")
disp("This makes sense as since we are dividing by numbers close to zero, small changes drastically change the outcome.")
disp(" ")

fx = @(x) x*exp(-x);
fpx = @(x)  exp(-x)-x*exp(-x);
tol = eps('single');
x0 = .5;
est = Newtons(fx, fpx, tol, x0, 0, 2.0001);
disp("F(x) = " + func2str(fx))
disp("F(x0) = " + x0)
disp("With tolerance of " + tol)
disp("Final estimation: " + est)
disp("In terms of convergence, we see that with p close to 2, our ratio moves much closer to 1 ")
disp(" ")

% 9
fx = @(x) 1-exp(x.^2);
fpx = @(x)  -2*x*exp(x.^2);
tol = eps('single');
x0 = 1;
est = Newtons(fx, fpx, tol, x0, 0, 2);
disp("F(x) = " + func2str(fx))
disp("F(x0) = " + x0)
disp("With tolerance of " + tol)
disp("Final estimation: " + est)
disp("Using ratio p=2, we see an extremly high ratio, meaning the order of convergence is most likly not P")
disp(" ")

fx = @(x) 1-exp(x.^2);
fpx = @(x)  -2*x*exp(x.^2);
tol = eps('single');
x0 = 1;
est = Newtons(fx, fpx, tol, x0, 0, 1);
disp("F(x) = " + func2str(fx))
disp("F(x0) = " + x0)
disp("With tolerance of " + tol)
disp("Final estimation: " + est)
disp("Using ratio p=1, we see a much more normal ratio around .5, meaning")
disp(" ")
