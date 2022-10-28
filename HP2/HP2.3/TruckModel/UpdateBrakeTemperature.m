function brakeTemp = UpdateBrakeTemperature(brakeTemp, ambientTemp, deltaTime, ch, tau, brakePressure, lowBrakePressure)
    deltaTemp = brakeTemp - ambientTemp;
    booleanDerivative = (brakePressure < lowBrakePressure);
    deltaTempPrime = booleanDerivative*(-(deltaTemp)/tau) + (~booleanDerivative)*(ch*brakePressure);
    deltaTemp = deltaTemp + deltaTempPrime*deltaTime;
    brakeTemp = ambientTemp + deltaTemp;
end