clear;
clc;
clf;
tic;
addpath('TruckModel')
addpath('ANN')
addpath('GA')

run("NetworkParameters.m")
network.nHidden = nHidden;
network.nIn = nIn;
network.nOut = nOut;
network.wMax = wMax;
network.wIH = NaN(nHidden, nIn+1);
network.wHO = NaN(nOut, nHidden+1);

run("GeneticAlgorithmParameters.m")
chromosomes = zeros(chromosomeLength, populationSize);
population = InitiatePopulation(populationSize, network);

maximumFitness = 0;
maximumValidationFitness = 0;
bestChromosome = NaN(chromosomeLength, 1);
bestWIH = zeros(nHidden, nIn+1);
bestWHO = zeros(nOut, nHidden+1);

bestNetworkValidation.wIH = zeros(nHidden, nIn+1);
bestNetworkValidation.wHO = zeros(nOut, nHidden+1);
bestFitnessListTraning = NaN(maxNumGenerations, 1);
bestFitnessListValidation = NaN(maxNumGenerations, 1);

for iGeneration = 1:maxNumGenerations
    fitnessListTraning = zeros(populationSize, 1);

    % Evaluate population with traning set
    parfor iPopulation = 1:populationSize
        network = population{iPopulation};
        fitnessTrain = zeros(10, 1);
        for iSlope = 1:10
            fitnessTrain(iSlope) = EvaluateTruker(network, iSlope, 1);
        end
        fitnessTrain = mean(fitnessTrain);
        fitnessListTraning(iPopulation) = fitnessTrain;
        chromosomes(:, iPopulation) = EncodeNetwork(network.wIH, network.wHO, network.wMax);
    end

    % Find the best chromosome this generation and save it if it's the best
    % chromosome yet
    [bestFitnessTraning, bestFitnessIndex] = max(fitnessListTraning);
    generationBestChromosome = chromosomes(:, bestFitnessIndex);
    bestFitnessListTraning(iGeneration) = bestFitnessTraning;
    if (bestFitnessTraning > maximumFitness)
        maximumFitness = bestFitnessTraning;
        bestChromosome = chromosomes(:, bestFitnessIndex);
        [bestWIH, bestWHO] = DecodeChromosome(bestChromosome, nIn, nHidden, nOut, wMax);

    end
    [validationWIH, validationWHO] = DecodeChromosome(generationBestChromosome, nIn, nHidden, nOut, wMax);

    %Evaluate best network with validation set
    fitnessValidation = zeros(5, 1);
    generationBestNetwork.wIH = validationWIH;
    generationBestNetwork.wHO = validationWHO;
    for iSlope = 1:5
        fitnessValidation(iSlope) = EvaluateTruker(generationBestNetwork, iSlope, 2);
    end
    fitnessValidation = mean(fitnessValidation);
    bestFitnessListValidation(iGeneration) = fitnessValidation;
    if fitnessValidation > maximumValidationFitness
        maximumValidationFitness = fitnessValidation;
        bestNetworkValidation.wIH = validationWIH;
        bestNetworkValidation.wHO = validationWHO;
    end

    % From next generation of networks
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessListTraning, populationSize, tournamentProbability);
        i2 = TournamentSelect(fitnessListTraning, populationSize, tournamentProbability);
        c1 = chromosomes(:, i1);
        c2 = chromosomes(:, i2);
        if (rand < crossoverProbability)
            [c1, c2] = Crossover(c1, c2);
        end
        [c1, c2] = Mutation(c1, c2, mutationProbability, chromosomeLength);

        [wIH, wHO] = DecodeChromosome(c1, nIn, nHidden, nOut, wMax);
        population{i}.wIH = wIH;
        population{i}.wHO = wHO;
        [wIH, wHO] = DecodeChromosome(c2, nIn, nHidden, nOut, wMax);
        population{i+1}.wIH = wIH;
        population{i+1}.wHO = wHO;
    end
    population{1}.wIH = bestWIH;
    population{1}.wHO = bestWHO;

    if (mod(iGeneration, 1500) == 0) && (0.85*maximumValidationFitness > fitnessValidation)
        break;
    end
end
toc
%%
PlotBestRunGA(bestFitnessListTraning, bestFitnessListValidation)

%%
matlab.io.saveVariablesToScript('BestChromosome.m','bestChromosome', 'SaveMode','update');
run("RunTest.m");
%%
% matlab.io.saveVariablesToScript('BestFitnessListTraning.m','bestFitnessListTraning', 'SaveMode','update');
% matlab.io.saveVariablesToScript('BestFitnessListValidation.m','bestFitnessListValidation', 'SaveMode','update');
% % Save best chromosome
% wIH = bestNetworkValidation.wIH;
% wHO = bestNetworkValidation.wHO;
% bestChromosome = EncodeNetwork(wIH, wHO, wMax);