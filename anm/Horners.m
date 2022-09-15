function [p, q] = Horners(poly, x0)
    % poly is of the form [a, a1x, a2x^2, ...]
    % Ex. [3, 2, 1] == 3 + 2x + x^2.
    % Returns p(x0) as p and p'(x0) as q
    p = poly(end);
    q = 0;
    for i = (length(poly)-1):-1:1
        q = p + x0 * q;
        p = poly(i) + x0 * p;
    end
end
