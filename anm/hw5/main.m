clc
% Define Functions
Fx = @(x) 2 * x - 3 * sin(x) + 5;
Gx = @(x) x^3 - 8.5 * x^2 + 20 * x - 8;

% 1 Plot Fx
figure;
fplot(Fx)
hold on
fplot(0)
legend 'Fx'
grid on
title("Plot of F(x)")
hold off

% 2b
[estimate, iterations, gx] = FixedPoint(Fx, 0, -2, 1e-5, 10);
% Plot y = gx and y=x
figure;
fplot(gx)
hold on
fplot(@(x) x)
legend ('Fx', 'y = x')
grid on
title("Plot of g(x) with y=x")
hold off

% 2c Plot g'x
figure;
gxPrime = @(x) abs(1- (2-3 * cos(x))/(k));
fplot(gxPrime)
hold on
fplot(1)
legend ("g'x", 'x = 1')
title("Plot of |g'(x)|")
grid on
hold off

% 2d
[estimate, iterations, gx] = FixedPoint(Fx, 2, -2, 1e-5, 20);
[estimate, iterations, gx] = FixedPoint(Fx, 5, -2, 1e-5, 20);

%2e
[estimate, iterations, gx] = FixedPoint(Fx, 16, -2, 1e-5, 50);

%3
[estimate, iterations, gx] = FixedPoint(Gx, 18, 4.5, 1e-5, 1000);
figure;
fplot(gx)
hold on
fplot(@(x) x)
disp("Estimate: " + estimate)
disp("iterations:" + iterations)

% 4
Fpx = @(x) 2 - 3 * cos(x);
Gpx = @(x) 3 * x^2 - 17 * x + 20;
x = Newtons(Fx, Fpx, 1e-10, -4.9);
x = Newtons(Fx, Fpx, 1e-10, -2);
x = NewtonsMulti(Gx, Gpx, 1e-10, 5, 2);
