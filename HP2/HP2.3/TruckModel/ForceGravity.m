function forceGravity = ForceGravity(forceGravity, mass, gravity, alpha)
    forceGravity = mass*gravity*sind(alpha);
end

% alphaFunction = GetSlopeAngleFunction(iSlope, iDataSet);
% alpha = alphaFunction(x);