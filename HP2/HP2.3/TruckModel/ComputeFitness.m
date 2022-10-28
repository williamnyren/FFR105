function fitness = ComputeFitness(x, xMax, vMean, vMax, iDrive)
lengthFitness = x/xMax;
if x >= xMax
    velocityFitness = 1.1*(vMean/iDrive)/vMax;
else
    velocityFitness = 0;
end
fitness = (lengthFitness + velocityFitness)/2;
end