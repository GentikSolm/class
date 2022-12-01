function res = Trap(fx, a, b, real)
    doubles = [2 4 8 16 32 64 128 256 512 1024 2048];
    slicesizes = (b - a)./(doubles);
    res = zeros(1,length(slicesizes));
    for i = 1:length(slicesizes)
        h = slicesizes(i);
        for slice = a:h:b-h
            res(i) = res(i) + h/2 * (fx(slice) + fx(slice+h));
        end
    end
    disp(table(doubles', res' , (res - real)', 'VariableNames', {'n Value', 'Trapezium Output', 'Error Calculated'}))
end

