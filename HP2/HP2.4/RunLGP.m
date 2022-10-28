clear;
clc;
data = LoadFunctionData;
xData = data(:, 1);
yData = data(:, 2);

nGeneration = 50000;
populationSize = 100;

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
yFit = zeros(lengthData-1, 1);
tic
for trial = 1:100
    population = InitializePopulation(populationSize, numGenesRange, operatorRange, destinationRange, operandRange);
    constantRegister = [0.1 0.33 1 2 3 4];
    for iGeneration = 1:nGeneration
        for i = 1:populationSize
            chromosome = population(i).Chromosome;
            [fitness, error] = EvaluateChromosome(chromosome, xData, yData, constantRegister, variableRegisterRange, mMax);
            fitnessList(i) = fitness;
        end
        [bestInGenerationVal, bestInGenerationIndex] = max(fitnessList);
        if (bestInGenerationVal > bestFitness)
            bestFitness = bestInGenerationVal;
            bestChromosome = population(bestInGenerationIndex).Chromosome;
            iBestChromosome = bestInGenerationIndex;

            for i = 1:lengthData-1
                yFit(i) = ChromosomeToInstrunctions(bestChromosome, 0.5*(xData(i+1) + xData(i)), constantRegister, variableRegisterRange);
            end
            slope = (yData(2:end) - yData(1:end-1))./(xData(2:end) - xData(1:end-1));
            errorRMS = rms(yFit - slope);


            % ###################################################################
            constantRegisterAsChar = string(constantRegister);
            variableRegister = zeros(1, variableRegisterRange);
            variableRegisterAsChar = string(variableRegister);
            variableRegisterAsChar(1) ="x";

            registers = [variableRegisterAsChar, constantRegisterAsChar];
            operators = ["+", "-", "*", "/"];

            chromosomeLength = length(bestChromosome);
            numGenes = chromosomeLength/4;
            genes = reshape(bestChromosome, 4, []);

            for i = 1:numGenes
                operator = genes(1, i);
                destination = genes(2, i);
                operand1 = genes(3, i);
                operand2 = genes(4, i);

                registers(destination) = "(" + registers(operand1) + operators(operator) + registers(operand2) + ")";

            end
            str = registers(1);
            y = str2sym(str);
            SimplifiedOutput = simplify(y,'Steps',25)
            % ###########################################################3


            disp(['New chromosome found: ',num2str(bestFitness),' | Erms = ', num2str(errorRMS),  ' | iGen: ', num2str(iGeneration), ' | iTrial= ', num2str(trial)])
            if errorRMS < 0.1
                date =  datetime('now', 'Format','yyyyMMdd_HH_mm_ss');
                save(['Derivative__',num2str(round(min(errorRMS)*1e5,0)),'_', char(date),'.mat'], 'bestChromosome', 'constantRegister');
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
        if mod(iGeneration, 507) == 0
            tmpPopulation(end).Chromosome = Mutate(bestChromosome, 0.001, operatorRange, destinationRange, operandRange);
        elseif mod(iGeneration, 1007) == 0
            tmpPopulation(end).Chromosome = Mutate(bestChromosome, 0.01, operatorRange, destinationRange, operandRange);
        elseif mod(iGeneration, 2007) == 0
            tmpPopulation(end).Chromosome = Mutate(bestChromosome, 0.1, operatorRange, destinationRange, operandRange);
        elseif mod(iGeneration, 5000) == 0
            tmpPopulation(end).Chromosome = Mutate(bestChromosome, 0.2, operatorRange, destinationRange, operandRange);
        else
            tmpPopulation(end).Chromosome = bestChromosome;
        end
        population = tmpPopulation;
    end

end
toc