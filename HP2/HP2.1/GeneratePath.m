function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    numberOfCities = size(pheromoneLevel, 1);
    
    % Functions as tabu list
    candidatesNextNode = true(numberOfCities, 1);
    nodes = 1:numberOfCities;
    nodes = nodes(:);

    path = zeros(numberOfCities, 1);

    startNode = randi(numberOfCities);
    path(1) = startNode;
    candidatesNextNode(startNode) = 0;

    nextNode = startNode;
    for iStep = 2:numberOfCities-1
        
        % Compute probability vector
        numerator = pheromoneLevel(candidatesNextNode, nextNode).^alpha...
            .* visibility(candidatesNextNode, nextNode).^beta;
        denominator = sum(numerator);
        probailityVector = numerator./denominator;
        
        % Roulette wheel selection from reachable nodes
        reachableNodes = nodes(candidatesNextNode);
        r = rand;
        nextNodeIndex = find(r <= cumsum(probailityVector), 1);
        
        nextNode = reachableNodes(nextNodeIndex);
        path(iStep) = nextNode;
        candidatesNextNode(nextNode) = 0;
    end
    nextNode = nodes(candidatesNextNode);
    path(end) = nextNode;
end