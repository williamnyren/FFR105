function foundationBrakes = FoundationBrakes(mass, brakePressure, brakeTemp, maxTemp, gravity)
    factor1 = mass*gravity*brakePressure/20;
    factor2 = exp(-(brakeTemp-(maxTemp-100))/100);
    booleanFactor = (brakeTemp < (maxTemp -100));
    foundationBrakes = booleanFactor*factor1 + (~booleanFactor)*factor1*factor2;
end