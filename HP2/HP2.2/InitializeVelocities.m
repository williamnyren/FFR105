function velocity = InitializeVelocities(xMax, xMin, alpha, vMax, timeStep, numberOfParticles, funcDim)
r = rand([funcDim, numberOfParticles]);
velocity = alpha*(-0.5*(xMax - xMin)+ r*(xMax - xMin))/timeStep;
end