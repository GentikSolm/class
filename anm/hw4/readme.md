# Driver
```matlab
clc
% q1.1
% Note, This range does NOT fit the criteria for the bisection method.
% fx(a) = 0, which causes fx(a) * fx(b) to be == 0
fx = @(x) x.^2 - sin(x);
[p, e, i] = Bisection(fx,0,pi,1e-6);
fprintf('\n--------------------\n')
disp("1.1 Bisection")
disp(['f(x) = ' func2str(fx)])
disp("p ~= " + p)
disp("At " + i + " Iterations")
disp("With an error of " + e)
clear

% q1.2
fx = @(x) 1-(2.*x.*exp(-x/2));
[p, e, i] = Bisection(fx,0,2,1e-6);
fprintf('\n--------------------\n')
disp("1.2 Bisection")
disp(['f(x) = ' func2str(fx)])
disp("p ~= " + p)
disp("At " + i + " Iterations")
disp("With an error of " + e)
clear

% q3.1
% Note, This range does NOT fit the criteria for the bisection method.
% fx(a) = 0, which causes fx(a) * fx(b) to be == 0
fx = @(x) x.^2 - sin(x);
[c, e, i] = RegulaFalsi(fx,0,pi,1e-6);
fprintf('\n--------------------\n')
disp("3.1 RegulaFalsi")
disp(['f(x) = ' func2str(fx)])
disp("p ~= " + c)
disp("At " + i + " Iterations")
disp("With an error of " + e)
clear

% q3.2
fx = @(x) 1-(2.*x.*exp(-x/2));
[c, e, i] = RegulaFalsi(fx,0,2,1e-6);
fprintf('\n--------------------\n')
disp("3.2 RegulaFalsi")
disp(['f(x) = ' func2str(fx)])
disp("p ~= " + c)
disp("At " + i + " Iterations")
disp("With an error of " + e)
clear

% q4.1
fx = @(x) exp(-4*x)-1/10;
[c, e, i] = Bisection(fx,0,5,1e-6);
fprintf('\n--------------------\n')
disp("4.1 Bisection")
disp(['f(x) = ' func2str(fx)])
disp("p ~= " + c)
disp("At " + i + " Iterations")
disp("With an error of " + e)
clear

% q4.2
fx = @(x) exp(-4*x)-1/10;
[c, e, i] = RegulaFalsi(fx,0,5,1e-6);
fprintf('\n--------------------\n')
disp("4.2 RegulaFalsi")
disp(['f(x) = ' func2str(fx)])
disp("p ~= " + c)
disp("At " + i + " Iterations")
disp("With an error of " + e)
clear

fprintf('\n')
disp("The Bisection method converges faster at 19 Iterations vs 58 of RegulaFalsi.")
disp("This is most likey due to the nature of the curve not 'playing nice' with Regula")
disp("Falsi formula's estimations")

% q5.1
fx = @(x) 1/(x-1);
[c, e, i] = Bisection(fx,0,3,3, 0);
fprintf('\n--------------------\n')
disp("5.1 Bisection")
disp(['f(x) = ' func2str(fx)])
disp("p ~= " + c)
disp("At " + i + " Iterations")
disp("With an error of " + e)
disp("This function does not cross the X axis.")
disp("When using the bisection method, C is driven to += infinity as it")
disp("spirals around the pole at x=1")
clear

% q5.2
fx = @(x) 1/(x-1);
[c, e, i] = RegulaFalsi(fx,0,3,3, 0);
fprintf('\n--------------------\n')
disp("5.2 RegulaFalsi")
disp(['f(x) = ' func2str(fx)])
disp("p ~= " + c)
disp("At " + i + " Iterations")
disp("With an error of " + e)
disp("This function does not cross the X axis.")
disp("When using the RegulaFalsi method, C is pushed towards the boundaries of the function")
clear

% q5.3
fx = @(x) 1/(x.^2+1);
[c, e, i] = Bisection(fx,0,5,3, 0);
fprintf('\n--------------------\n')
disp("5.3 Bisection")
disp(['f(x) = ' func2str(fx)])
disp("p ~= " + c)
disp("At " + i + " Iterations")
disp("With an error of " + e)
disp("This function does not cross the X axis.")
disp("When using the bisection method, C is driven to += infinity as it")
disp("spirals around the pole at x=1")
clear

% q5.4
fx = @(x) 1/(x.^2+1);
[c, e, i] = RegulaFalsi(fx,0,5,3, 0);
fprintf('\n--------------------\n')
disp("5.4 RegulaFalsi")
disp(['f(x) = ' func2str(fx)])
disp("p ~= " + c)
disp("At " + i + " Iterations")
disp("With an error of " + e)
disp("This function does not cross the X axis.")
disp("When using the RegulaFalsi method, C is pushed towards the boundaries of the function")

clear


```

# Funcs
```matlab
function [p, error, i] = Bisection(func, a, b, e, do_assert)
    % Returns
    %   p       - estimated root
    %   error   - error from real root
    %   i       - number of iterations
    % Paramaters
    %   func    - Function to test
    %   a       - lower bound
    %   b       - upper bound
    %   e       - error thresh-hold, default @ 1 * 10^-6
    %   do_assert - Flag to skip asserts in case of infinate loop
    
    if nargin == 5
        if do_assert
            assert(a < b)
            assert(func(a) * func(b) <= 0)
        end
    end
    if nargin > 3
        error_thresh = e;
    else
        error_thresh = 1e-6;
    end
    i = 0;
    while 1
        i = i+1;
        p = (a+b)/2;
        error = func(p);
        if(error * func(a) > 0)
            a = p;
        else
            b = p;
        end
        error = abs(error);
        if(error < error_thresh)
            break;
        end
    end
end


```

```matlab
function [c, error, i] = RegulaFalsi(func, a, b, e, do_assert)
    % Returns
    %   p       - estimated root
    %   error   - error from real root
    %   i       - number of iterations
    % Paramaters
    %   func    - Function to test
    %   a       - lower bound
    %   b       - upper bound
    %   e       - error thresh-hold, default @ 1 * 10^-6
    %   do_assert - Flag to skip asserts in case of infinate loop
    if nargin == 5
        if do_assert
            assert(a < b)
            assert(func(a) * func(b) <= 0)
        end
    end
    if nargin > 3
        error_thresh = e;
    else
        error_thresh = .01;
    end
    i = 0;
    while 1
        i = i+1;
        c = (a*func(b)-b*func(a))/(func(b)-func(a));
        error = func(c);
        if(error * func(a) < 0)
            b = c;
        else
            a = c;
        end
        error = abs(error);
        if(error < error_thresh)
            break;
        end
    end
end


```
