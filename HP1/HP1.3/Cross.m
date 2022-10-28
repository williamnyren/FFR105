function newIndividuals = Cross(individual1, individual2)
    nGenes = length(individual1);
    nGenes = length(individual2);
    newIndividuals = zeros(2, nGenes);
    crossoverPoint = 1 + fix(rand*(nGenes-1));
    newIndividuals(1, 1:crossoverPoint) = individual1(1:crossoverPoint);
    newIndividuals(2, 1:crossoverPoint) = individual2(1:crossoverPoint);
    newIndividuals(1, crossoverPoint+1:end) = individual2(crossoverPoint+1:nGenes);
    newIndividuals(2, crossoverPoint+1:end) = individual1(crossoverPoint+1:nGenes);
end