function path = NearestNeighbor(cityLocation)
    
    numberOfCities = length(cityLocation);
    path = zeros(numberOfCities, 1);
    cityLocation = cityLocation'; % Transpose to iterate nodes as column vectors in the for-loop
    % Compute eta in a vectorized manner without dubble computation and
    % assume direction dependent 
    node = randi(numberOfCities);
    nextNodeLocations = cityLocation;
    for i = 1:length(cityLocation)
        path(i) = node;
        startNodeLocation = cityLocation(:, node);
        nextNodeLocations(:, node) = inf;
        d = vecnorm(nextNodeLocations - startNodeLocation);
        [~, nextNode] = min(d);
        node = nextNode;
    end
end