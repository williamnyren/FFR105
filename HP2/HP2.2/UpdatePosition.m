function position = UpdatePosition(particle, timeStep)
position = particle.position + particle.velocity*timeStep;
end