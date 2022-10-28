function mutatedChromosome = Mutate(chromosome, mutationProbability, operatorRange, destinationRange, operandRange)
chromosomeLength = length(chromosome);
nGenes = chromosomeLength/4;
tmpMutatedChromosome = zeros(chromosomeLength, 1);

newOperator = randi(operatorRange, 1, nGenes);
newDestination = randi(destinationRange, 1, nGenes);
newOperand1 = randi(operandRange, 1, nGenes);
newOperand2 = randi(operandRange, 1, nGenes);
tmpMutatedChromosome(1:4:chromosomeLength) = newOperator;
tmpMutatedChromosome(2:4:chromosomeLength) = newDestination;
tmpMutatedChromosome(3:4:chromosomeLength) = newOperand1;
tmpMutatedChromosome(4:4:chromosomeLength) = newOperand2;
acceptedMutations = (rand(1, chromosomeLength) < mutationProbability);
chromosome(acceptedMutations) = tmpMutatedChromosome(acceptedMutations);
mutatedChromosome = chromosome;
end