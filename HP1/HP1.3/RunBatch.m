%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfRuns = 100;                % Do NOT change
populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;		   % Do NOT change
numberOfGenerations = 300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define more runs here (pMut < 0.02) ...
mutationProbabilityLessThan002 = [0 0.01 0.012 0.014 0.016 0.018];
maximumFitnessListLessThan002 = zeros(numberOfRuns, length(mutationProbabilityLessThan002));
parfor imutationProbabilityIndex = 1:1:length(mutationProbabilityLessThan002)
    mutationProbability = mutationProbabilityLessThan002(imutationProbabilityIndex);
    sprintf('Mutation rate = %0.5f', mutationProbability)
    for i = 1:numberOfRuns
        [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
            tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
        sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
        maximumFitnessListLessThan002(i,imutationProbabilityIndex) = maximumFitness;
    end
end

%Runs pMut = 0.02 here ...
mutationProbability = 0.02;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList002 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns
    [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
        tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
    sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
    maximumFitnessList002(i,1) = maximumFitness;
end


% ... and here (pMut > 0.02)
mutationProbabilityGreaterThan002 = [0.025 0.03 0.05 0.1 0.2 0.5 0.7 1];
maximumFitnessListGreaterThan002 = zeros(numberOfRuns, length(mutationProbabilityGreaterThan002));
parfor imutationProbabilityIndex = 1:1:length(mutationProbabilityGreaterThan002)
    mutationProbability = mutationProbabilityGreaterThan002(imutationProbabilityIndex);
    sprintf('Mutation rate = %0.5f', mutationProbability)
    for i = 1:numberOfRuns
        [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
            tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
        sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
        maximumFitnessListGreaterThan002(i, imutationProbabilityIndex) = maximumFitness;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add more results summaries here (pMut < 0.02) ...

averageLessThan002 = mean(maximumFitnessListLessThan002);
medianLessThan002 = median(maximumFitnessListLessThan002);
stdLessThan002 = sqrt(var(maximumFitnessListLessThan002));
sprintf('PMut < 0.02: Median: %0.10f, Average: %0.10f, STD: %0.10f', medianLessThan002, averageLessThan002, stdLessThan002)

%Runs pMut = 0.02 here ...
average002 = mean(maximumFitnessList002);
median002 = median(maximumFitnessList002);
std002 = sqrt(var(maximumFitnessList002));
sprintf('PMut < 0.02: Median: %0.10f, Average: %0.10f, STD: %0.10f', median002, average002, std002)

% ... and here (pMut > 0.02)
averageGreaterThan002 = mean(maximumFitnessListGreaterThan002);
medianGreaterThan002 = median(maximumFitnessListGreaterThan002);
stdGreaterThan002 = sqrt(var(maximumFitnessListGreaterThan002));
sprintf('PMut > 0.02: Median: %0.10f, Average: %0.10f, STD: %0.10f', medianGreaterThan002, averageGreaterThan002, stdGreaterThan002)

% Draw plots
subplot(2, 1, 1)
plot([mutationProbabilityLessThan002 mutationProbability mutationProbabilityGreaterThan002], [medianLessThan002 median002 medianGreaterThan002], 'or-.')
grid on
title('Maximum fitness score')
axis([0 1 0.97 1.01])
ylabel('Median')
xlabel('$p_{mut}$')
subplot(2, 1, 2)
plot([mutationProbabilityLessThan002 mutationProbability mutationProbabilityGreaterThan002],...
    [stdLessThan002 std002 stdGreaterThan002], 'bo-.')
grid on
axis([-0.01 1 -0.01 0.07])
xlabel('$p_{mut}$')
ylabel('Standard deviation')