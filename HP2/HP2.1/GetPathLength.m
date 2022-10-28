function pathLength = GetPathLength(path, cityLocation)
    % stepTo(i) represents the next node to step to from node path(i).
    % Including endNode to startNode
    stepTo = [path(2:end); path(1)];
    stepLength = vecnorm(cityLocation(stepTo, :)...
        - cityLocation(path, :), 2, 2);

    pathLength = sum(stepLength);
end