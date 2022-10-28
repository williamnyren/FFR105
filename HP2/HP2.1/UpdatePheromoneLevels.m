function pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel, deltaPheromoneLevel, rho)
    pheromoneLevel = (1 - rho)*pheromoneLevel + deltaPheromoneLevel;
    pheromoneLevel(pheromoneLevel < 1e-15) = 1e-15;
end