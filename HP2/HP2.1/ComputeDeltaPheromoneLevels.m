function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection, pathLengthCollection)
    [numberOfAnts, numberOfCities] = size(pathCollection);
    deltaPheromoneLevel = zeros(numberOfCities);
    pathLengthCollectionInverse = 1./pathLengthCollection;
    % Append start node to compute the step from end node to start node.
    pathCollection = [pathCollection, pathCollection(:, 1)];
    for k = 1:numberOfAnts
        path = pathCollection(k, :);
        iStep = 1;
        dInv = pathLengthCollectionInverse(k);
        for stepFrom = path(1:end-1)
            iStep = iStep + 1;
            stepTo = path(iStep);
            deltaPheromoneLevel(stepTo, stepFrom) = deltaPheromoneLevel(stepTo, stepFrom) + dInv;
        end
    end
end