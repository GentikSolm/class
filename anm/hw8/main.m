clc
clear
% Problem 2
% Define Functions
Fx = @(x) exp(x);
n = [2 4 8 16 32];
errors = 1:length(n);
for i=1:length(n)
    [px, error] = Newton(Fx, -1, 1, n(i));
    errors(i) = error;
    disp("Error for n = "+ n(i))
    disp(error)
    disp("px for n = "+ n(i))
    disp(px)
end

% Plot of Error vs n
figure
plot(n, errors)

% Interesting graph of Fx vs px
figure
x = linspace(-10,10,900);
fy = Fx(x);
plot(x, fy)
hold on
py = px(x);
plot(x, py)
ylim([-3 3])
hold off

% Problem 3
fx1 = @(x) log(x);
fx2 = @(x) x.^2 .* exp(-x);
fx1real = 3 * log(3) - 2;
fx2real = 2-10 * exp(-2);

disp('fx1')
Trap(fx1, 1, 3, fx1real);
disp('fx2')
Trap(fx2, 0, 2, fx2real);

disp('fx1')
Simp(fx1, 1, 3, fx1real);
disp('fx2')
Simp(fx2, 0, 2, fx2real);

disp('fx1')
CompTrap(fx1, 1, 3, fx1real, @(x) 1/x);
disp('fx2')
CompTrap(fx2, 0, 2, fx2real, @(x) 2*exp(-x)*x-exp(-x)*x^2);

% Problem 5
n = [1 2 4 8 16];
results = 1:length(n);
for i=1:length(n)
    res = Gauss(fx1, 1, 3, n(i));
    results(i) = res;
end
disp('fx1')
disp(table(n', results' , (results - fx1real)', 'VariableNames', {'n Value', 'Gauss Quad', 'Error Calculated'}))

for i=1:length(n)
    res = Gauss(fx2, 0, 2, n(i));
    results(i) = res;
end
disp('fx2')
disp(table(n', results' , (results - fx2real)', 'VariableNames', {'n Value', 'Gauss Quad', 'Error Calculated'}))
