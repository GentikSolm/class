function x = NewtonsMulti(fx, fpx, tol, x0, m)
%NEWTONS Summary of this function goes here
%   Determins an approximation to the root given fx, fpx, a tolorant and x0
    x = x0;
    xlast = 0;
    i = 0;
    while (abs(fx(x)) + abs(x-xlast)) > tol
        xlast = x;
        x = x - m * fx(x)/fpx(x);
        disp("iteration " + i + ": " + x)
        i = i + 1;
    end
end

