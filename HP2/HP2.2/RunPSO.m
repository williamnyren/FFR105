clear;
clc;
%Run PSO until all four minima is found
joblist = [1, 1, 1, 1];
while ~isequal(joblist, [0, 0, 0, 0])
    xMin = -5;
    xMax = 5;
    
    numberOfParticles = 30;
    funcDim = 2;
    
    % Initial conditions
    alpha = 1;
    beta = 0.95;
    timeStep = 1;
    vMax =(xMax - xMin)/timeStep;
    w = 1.4;
    wLowerBound = 0.3;
    
    cognitiveComponent = 2;
    socialComponent = 2;
    
    position = InitializePositions(xMax, xMin, numberOfParticles, funcDim);
    velocity = InitializeVelocities(xMax, xMin, alpha, vMax, timeStep, numberOfParticles, funcDim);
    
    particles = struct();
    particles.position = position;
    particles.velocity = velocity;
    particles.bestPosition = position;
    particles.bestValue = ObjectiveFunction(particles.position(1, :), particles.position(2, :));
    [bestPerformance, bestPerformanceIndex] =  min(particles.bestValue);
    particles.bestPerformance = bestPerformance;
    particles.bestPerformancePosition = particles.position(:, bestPerformanceIndex);
    
    while particles.bestPerformance > 1e-16
        particleFuncValue = ObjectiveFunction(particles.position(1, :), particles.position(2, :));
        [bestPerformance, bestPerformanceIndex] = min(particleFuncValue);
        
        booleanChoice = (bestPerformance <= particles.bestPerformance);
        particles.bestPerformance = booleanChoice*bestPerformance +...
            (~booleanChoice)*particles.bestPerformance;
        
        particles.bestPerformancePosition = ...
            booleanChoice*particles.position(:, bestPerformanceIndex) +...
            (~booleanChoice)*particles.bestPerformancePosition;
        
        booleanChoices = (particleFuncValue <= particles.bestValue);
        particles.bestPosition = booleanChoices.*particles.position +...
            (~booleanChoices).*particles.bestPosition;
        
        particles.velocity = UpdateVelocity(particles, cognitiveComponent, socialComponent,...
            vMax, w, timeStep, numberOfParticles, funcDim);
        particles.position = UpdatePosition(particles, timeStep);
        
        booleanChoice = (w*beta >= wLowerBound);
        w = booleanChoice*w*beta + (~booleanChoice)*wLowerBound;
    end
    xBest = particles.bestPerformancePosition(1, :);
    yBest = particles.bestPerformancePosition(2, :);
    vBest = particles.bestPerformance;
    
    output = [xBest, yBest, vBest];
    % Save only new minima
    if (xBest >= 0) && (yBest >= 0) && (joblist(1) == 1)
        joblist(1) = 0;
        save(['x_', num2str(xBest), '_y_', num2str(yBest), '.mat'], 'output');
    elseif (xBest <= 0) && (yBest >= 0) && (joblist(2) == 1)
        joblist(2) = 0;
        save(['x_', num2str(xBest), '_y_', num2str(yBest), '.mat'], 'output');
    elseif (xBest <= 0) && (yBest <= 0) && (joblist(3) == 1)
        joblist(3) = 0;
        save(['x_', num2str(xBest), '_y_', num2str(yBest), '.mat'], 'output');
    elseif (xBest >= 0) && (yBest <= 0) && (joblist(4) == 1)
        joblist(4) = 0;
        save(['x_', num2str(xBest), '_y_', num2str(yBest), '.mat'], 'output');
    end
end

run('ContourPlot.m')
