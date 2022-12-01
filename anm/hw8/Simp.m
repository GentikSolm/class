function res = Simp(fx, a, b, real)
    doubles = [2 4 8 16 32 64 128 256 512 1024 2048];
    slicesizes = (b - a)./(doubles);
    res = zeros(1,length(slicesizes));
    for i = 1:length(slicesizes)
        h = slicesizes(i);
        xi=a:h:b;
        res(i) = h/3*(fx(xi(1))+2*sum(fx(xi(3:2:end-2)))+4*sum(fx(xi(2:2:end)))+fx(xi(end)));
    end
    disp(table(doubles', res' , (res - real)', 'VariableNames', {'n Value', 'Simp Output', 'Error Calculated'}))
end