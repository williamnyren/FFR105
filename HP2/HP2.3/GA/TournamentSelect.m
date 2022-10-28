function individualIndex = TournamentSelect(fitnessList, populationSize, tournamentProbability)
    competitors = randperm(populationSize);
    tournamentFitnessScore = fitnessList(competitors);
    [~, indexOriginalOrder] = sort(tournamentFitnessScore, 'descend');
    
    selectionTests = [(rand() < tournamentProbability), 1];
    tournamentDepthToTermination = find(selectionTests, 1);
    individualIndex = indexOriginalOrder(tournamentDepthToTermination);
end