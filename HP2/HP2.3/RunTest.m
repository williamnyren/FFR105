
addpath('TruckModel')
addpath('ANN')

%The chromosome in the report figure was overwritten. I managed to 
% reproduce it pretty well with BestChromosomePlot.m
run("NetworkParameters.m");
run('BestChromosome.m');

[wIH, wHO] = DecodeChromosome(bestChromosome, nIn, nHidden, nOut, wMax);
bestNetwork.wIH = wIH;
bestNetwork.wHO = wHO;

% Pick dataset and slope. iDataSet: {1:Training, 2:Validation, 3:Test}
% Range iSlope: {Training:[1:10], Validation:[1:5], Test:[1:5]}
iDataSet = 3;
iSlope = 1;
[fitness, tripLog] = RunBestTruker(bestNetwork, iSlope, iDataSet);
PlotTruckPath(tripLog, iSlope, iDataSet);
