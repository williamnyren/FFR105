function mutatedIndividual = Mutate(individual, mutationProbability);
    nGenes = length(individual);
    mutatedIndividual = individual;
    mutations = (rand(1, nGenes) < mutationProbability);
    mutatedIndividual(mutations) = 1-individual(mutations);
end