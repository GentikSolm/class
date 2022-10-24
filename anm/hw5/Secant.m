function x = Secant(fx, tol, x0)
%NEWTONS Summary of this function goes here
%   Determins an approximation to the root given fx, fpx, a tolorant and x0
    x = x0;
    xlast = 0;
    i = 0;
    while abs(fx(x)) + abs(x-xlast) > tol
        prevx = x;
        x = x - fx(x) * ((x - xlast)/(fx(x)-fx(xlast)));
        xlast = prevx;
        disp("iteration " + i + ": " + x)
        i = i + 1;
    end
end

