function [estimate, iterations, gx] = FixedPoint(fx, k, x0, error, maxIter)
    gx = @(x) x - fx(x) / (2 + k);
    estimate = gx(x0);
    iterations = 1;
    disp("n: " + iterations)
    disp("xn: " + estimate)
    while abs(estimate - x0) > error && maxIter > iterations
        iterations = iterations + 1;
        x2 = x0;
        x0 = estimate;
        estimate = gx(x0);
        disp("n: " + iterations)
        disp("xn: " + estimate)
    end
end

