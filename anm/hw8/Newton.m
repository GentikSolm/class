function [px,error] = Newton(fx, lower, upper, nodes)
    interval = linspace(lower,upper,nodes+1);
    n = length(interval);
    b = zeros(n,n);
    fxi = fx(interval);
    b(:,1) = fxi(:);
    for j=2:n
        for i=1:n-j+1
            b(i,j) = (b(i+1,j-1)-b(i,j-1))/(interval(i+j-1)-interval(i));
        end
    end
    px = @(x) b(1,1);
    for j=2:n
        polyx = @(x) b(1,j);
        for i=2:j
            polyx = @(x) polyx(x) .* (x - interval(i-1));
        end
        px = @(x) px(x) + polyx(x);
    end
    tk = -1 + ((2 * (0:500))./500);
    error=max(fx(tk)-px(tk));
end

