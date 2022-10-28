function population = InitiatePopulation(populationSize, network)
wMax = network.wMax;
nHidden = network.nHidden;
nIn = network.nIn;
nOut = network.nOut;
population = cell([populationSize, 1]);
for i = 1:populationSize
    population{i} = network;
    population{i}.wIH = randi([-wMax, wMax], nHidden, nIn+1);
    population{i}.wHO = randi([-wMax, wMax], nOut, nHidden+1);
    population{i}.wIH(:, end) = 0;
    population{i}.wHO(:, end) = 0;
end
end