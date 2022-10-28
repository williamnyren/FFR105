function positions = InitializePositions(xMax, xMin, numberOfParticles, funcDim)
r = rand([funcDim, numberOfParticles]);
positions = xMin + r*(xMax - xMin);
end