clear;
clc;
data = LoadFunctionData;
xData = data(:, 1);
yData = data(:, 2);

nGeneration = 50000;
populationSize = 1000;

numGenesRange = [2;25];


operatorRange = 4; %{+, -, *, /}
variableRegisterRange = 4;
constantRegisterRange = 6;
operandRange = variableRegisterRange + constantRegisterRange;
destinationRange = variableRegisterRange;

tournamentProbability = 0.75;
tournamentSize = 5;
crossoverProbability = 0.2;
mutationProbability = 0.04;

bestFitness = -1;
mMax = 300;
fitnessList = zeros(populationSize, 1);
lengthData = length(yData);
yFit = zeros(lengthData, 1);
tic
for tial = 1:100
    population = InitializePopulation(populationSize, numGenesRange, operatorRange, destinationRange, operandRange);
    constantRegister = [0.1 0.33 0.5 1 3 5];
    for iGeneration = 1:nGeneration
        parfor i = 1:populationSize
            chromosome = population(i).Chromosome;
            [fitness, error] = EvaluateChromosome(chromosome, xData, yData, constantRegister, variableRegisterRange, mMax);
            fitnessList(i) = fitness;
        end
        [bestInGenerationVal, bestInGenerationIndex] = max(fitnessList);
        if (bestInGenerationVal > bestFitness)
            bestFitness = bestInGenerationVal;
            bestChromosome = population(bestInGenerationIndex).Chromosome;
            iBestChromosome = bestInGenerationIndex;

            for i = 1:lengthData
                yFit(i) = ChromosomeToInstrunctions(bestChromosome, xData(i), constantRegister, variableRegisterRange);
            end
            errorRMS = rms(yFit - yData);
            disp(['New chromosome found: ',num2str(bestFitness), ' | iter: ', num2str(iGeneration)])
            if sqrt(mean((yFit - yData).^2)) < 0.01
                date =  datetime('now', 'Format','yyyyMMdd_HH_mm_ss');
                save(['L__',num2str(round(min(errorRMS)*1e5,0)),'_', char(date),'.mat'], 'bestChromosome', 'constantRegister');
            end
        end

        tmpPopulation = population;
        for i = 1:2:populationSize
            i1 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
            i2 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
            chromosome1 = population(i1).Chromosome;
            chromosome2 = population(i2).Chromosome;

            r = rand;
            if (r < crossoverProbability)
                [chromosome1, chromosome2, len1, len2] = TwoPointCross(chromosome1, chromosome2);
            else
                len1 = length(chromosome1);
                len2 = length(chromosome2);
            end
            chromosome1 = Mutate(chromosome1, mutationProbability, operatorRange, destinationRange, operandRange);
            chromosome2 = Mutate(chromosome2, mutationProbability, operatorRange, destinationRange, operandRange);
            tmpPopulation(i).Chromosome = chromosome1;
            tmpPopulation(i+1).Chromosome = chromosome2;
        end
        if mod(iGeneration, 1000) == 0
            tmpPopulation(end).Chromosome = Mutate(bestChromosome, 0.1, operatorRange, destinationRange, operandRange);
        else
            tmpPopulation(end).Chromosome = bestChromosome;
        end
        population = tmpPopulation;
    end

end
toc