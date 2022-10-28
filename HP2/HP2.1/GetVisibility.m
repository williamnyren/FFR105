function visibility = GetVisibility(cityLocation)
    numberOfCities = length(cityLocation);
    visibility = zeros(numberOfCities);
    
    cityLocation = cityLocation'; % Transpose to iterate "toCity" as column vectors in the for-loop
    diagonalOffsetIndex = 2;
    columnIndex = 1;
    rowIndex = 1;
    % Compute eta in a vectorized manner without dubble computation and
    % assume direction dependent, i.e (eta_ij ~= eta_ji)
    for fromCity = cityLocation
        toCities = cityLocation(:, diagonalOffsetIndex:end);

        d1 = vecnorm(toCities - fromCity, 2);
        d2 = vecnorm(fromCity - toCities, 2);
        visibility(diagonalOffsetIndex:end, columnIndex) = 1./d1;
        visibility(rowIndex, diagonalOffsetIndex:end) = 1./d2;
        columnIndex = columnIndex + 1;
        rowIndex = rowIndex + 1;
        diagonalOffsetIndex = diagonalOffsetIndex + 1;
    end
end