function population = InitializePopulation(populationSize, numGenesRange, operatorRange, destinationRange, operandRange)
minNumberOfGenes = numGenesRange(1);
maxNumberOfGenes = numGenesRange(2);
chromosomeLengths = 4*randi([minNumberOfGenes, maxNumberOfGenes], populationSize,  1);
numGenes = chromosomeLengths/4;
population = struct();
i = 0;
for numGene = numGenes'
    i = i+1;
    chromosomeLength = chromosomeLengths(i);
    chromosome = NaN(chromosomeLength, 1);
    operatorValues = randi([1, operatorRange], numGene, 1);
    registerValues = randi([1, destinationRange], numGene, 1);
    operandValues1 = randi([1, operandRange], numGene, 1);
    operandValues2 = randi([1, operandRange], numGene, 1);
    chromosome(1:4:chromosomeLength) = operatorValues;
    chromosome(2:4:chromosomeLength) = registerValues;
    chromosome(3:4:chromosomeLength) = operandValues1;
    chromosome(4:4:chromosomeLength) = operandValues2;
    population(i).Chromosome = chromosome;
end

end