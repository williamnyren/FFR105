function path = GeneratePathFast(pheromoneLevel, visibility, alpha, beta)
numberOfCities = size(pheromoneLevel, 1);

% Functions as tabu list
candidatesNextNode = true(numberOfCities, 1);
nodes = 1:numberOfCities;
nodes = nodes(:);

path = zeros(numberOfCities, 1);

startNode = randi(numberOfCities);
path(1) = startNode;
candidatesNextNode(startNode) = false;

nextNode = startNode;

tauPowAlpha = pheromoneLevel;
for iAlpha = 2:alpha
    tauPowAlpha = tauPowAlpha.*pheromoneLevel;
end

etaPowBeta = visibility;
for iBeta = 2:beta
    etaPowBeta = etaPowBeta.*visibility;
end

numerators = tauPowAlpha.* etaPowBeta;
numerators(nextNode, :) = 0;

remove = zeros(1, numberOfCities);
for iStep = 2:numberOfCities-1
    
    numerator = numerators(:, nextNode);
    numerators(nextNode, :) = numerators(nextNode, :).*remove;
    % Compute probability vector
    denominator = sum(numerator);

    % Roulette wheel selection from reachable nodes
    nextNode = find(rand*denominator < cumsum(numerator), 1);

    path(iStep) = nextNode;
    candidatesNextNode(nextNode) = false;
end
nextNode = nodes(candidatesNextNode);
path(end) = nextNode;
end