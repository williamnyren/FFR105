function velocity = UpdateVelocity(particle, cognitiveComponent, socialComponent,...
    vMax, w, timeStep, numberOfParticles, funcDimn)
velocity = particle.velocity;
position = particle.position;
bestPosition = particle.bestPosition;
bestPerformancePosition = particle.bestPerformancePosition;

q = rand([1, numberOfParticles]);
r = rand([1, numberOfParticles]);
velocity = w*velocity +(cognitiveComponent*q.*(bestPosition - position) +...
    socialComponent*r.*(bestPerformancePosition - position))/timeStep;

booleanRestrict = (velocity >= vMax);
velocity(booleanRestrict) = vMax;
booleanRestrict = (velocity <= -vMax);
velocity(booleanRestrict) = -vMax;

end