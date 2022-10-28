function [c1, c2] = Mutation(c1, c2, mutationProbability, chromosomeLength)
    r = rand(chromosomeLength, 2);
    mutations = (r < mutationProbability);
    v = (rand(chromosomeLength, 2)-0.5)*2; 
    mutationValue = v.*mutations;
    c1(mutations(:, 1)) = mutationValue(mutations(:, 1));
    c2(mutations(:, 2)) = mutationValue(mutations(:, 2));
end