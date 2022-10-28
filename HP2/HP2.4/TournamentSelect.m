function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)
    numberOfIndividuals = length(fitnessList);
    selectedIndividualIndices = randperm(numberOfIndividuals, tournamentSize);
    selectedIndividualScore = fitnessList(selectedIndividualIndices);

    selectionTest = (rand(1, tournamentSize) < tournamentProbability);
    selectionTest(end) = 1;
    tournamentDepthToTermination = find(selectionTest);
    tournamentDepthToTermination = tournamentDepthToTermination(1);
    [~, indexOriginalOrder] = sort(selectedIndividualScore, 'descend');
    selectedIndividualSubsetIndex = indexOriginalOrder(tournamentDepthToTermination);
    selectedIndividualIndex = selectedIndividualIndices(selectedIndividualSubsetIndex);
end