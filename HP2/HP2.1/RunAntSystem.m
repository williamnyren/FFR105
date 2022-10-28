%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ant system (AS) for TSP.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
beep off
clf;
addpath('TSPgraphics')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cityLocation = LoadCityLocations();
numberOfCities = length(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfAnts = 50;  %% Changes allowed
alpha = 1;          %% Changes allowed
beta = 2;           %% Changes allowed
rho = 0.5;         %% Changes allowed

nearestNeighborPath = NearestNeighbor(cityLocation);
nearestNeighborPathLength = GetPathLength(nearestNeighborPath, cityLocation);
tau0 = numberOfAnts/nearestNeighborPathLength;         %%Changes allowed

targetPathLength = 123;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To do: Add plot initialization
range = [0 20 0 20];
tspFigure = InitializeTspPlot(cityLocation, range);
connection = InitializeConnections(cityLocation);
pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0);
visibility = GetVisibility(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minimumPathLength = inf;

iIteration = 0;
pathCollection = zeros(numberOfAnts, numberOfCities);
pathLengthCollection = zeros(numberOfAnts,1);
bestPath = zeros(numberOfCities, 1);
tic
% for trial = 1:288
% while (minimumPathLength > targetPathLength)
for run = 1:500
    iIteration = iIteration + 1;

    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate paths:
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    for k = 1:numberOfAnts
        path = GeneratePathFast(pheromoneLevel, visibility, alpha, beta);
        %         path = GeneratePath(pheromoneLevel, visibility, alpha, beta);
        pathLength = GetPathLength(path,cityLocation);
        if (pathLength < minimumPathLength)
            bestPath = path;
            minimumPathLength = pathLength;
%             disp(sprintf('Iteration %d, ant %d: path length = %.5f',iIteration,k,minimumPathLength));
%             PlotPath(connection,cityLocation, path);
        end
        pathCollection(k,:) = path;
        pathLengthCollection(k) = pathLength;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Update pheromone levels
    %%%%%%%%%%%%%%%%%%%%%%%%%%

    deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection, pathLengthCollection);
    pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel, deltaPheromoneLevel, rho);
end
toc

% Save best path to .m file
if minimumPathLength < 121.75337
    disp(sprintf('Iteration %d, ant %d: path length = %.5f',iIteration, k, minimumPathLength));
    PlotPath(connection, cityLocation, bestPath);
    date =  datetime('now', 'Format','yyyyMMdd_HH_mm_ss');
    matlab.io.saveVariablesToScript(['BestResultFound_',num2str(round(minimumPathLength, 0)),'_', char(date) ,'.m'],'bestPath');
end
% end



