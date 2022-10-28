function data = ProduceData(x, y)
    rows = length(x);
    z = TwoSurface(x, y);
    data = zeros(rows, 3);
    data(:, 1) = x;
    data(:, 2) = y;
    data(:, 3) = z;
    
end