function [fitness, tripLog] = RunBestTruker(network, iSlope, iDataSet)

[maxTemp, mass, tau, ch, ambientTemp, cb, vMax, vMin,...
    alphaMax, deltaTime, xMax, gravity, lowBrakePressure,...
    gearEncodingHigh, gearEncodingLow, x, v, vDot, alpha, brakeTemp,...
    pedalPressure, gear,forceGravity, forceEB, forceFB] = SimulationParameters(iSlope, iDataSet);

% Append element "1" to include bias term
networkInput = [v/vMax; alpha/alphaMax; brakeTemp/maxTemp; 1];
wIH = network.wIH;
wHO = network.wHO;

gearIterDelay = ceil(2/deltaTime);
gearIter =  gearIterDelay -1;
numMaxIters = ceil((vMin/deltaTime)*xMax);

% Save trip data for plot
tripLog = NaN(6, numMaxIters);
for iDrive = 1:numMaxIters

    booleanBreak = (xMax <= x) + (v < vMin)  + (max(networkInput) > 1);
    if booleanBreak > 0
        if ((xMax <= x) == 1) && ((v < vMin) == 0) && ((max(networkInput) > 1) == 0)
            tripLog(1, iDrive) = alpha;
            tripLog(2, iDrive) = pedalPressure;
            tripLog(3, iDrive) = gear;
            tripLog(4, iDrive) = v;
            tripLog(5, iDrive) = brakeTemp;
            tripLog(6, iDrive) = x;
        end
        break;
    end
    tripLog(1, iDrive) = alpha;
    tripLog(2, iDrive) = pedalPressure;
    tripLog(3, iDrive) = gear;
    tripLog(4, iDrive) = v;
    tripLog(5, iDrive) = brakeTemp;
    tripLog(6, iDrive) = x;

    [pedalPressure, shiftGearSignal] = RunFFNN(networkInput, wIH, wHO );
    [gear, gearIter] = UpdateGear(gear, shiftGearSignal, gearIter, gearIterDelay, gearEncodingLow, gearEncodingHigh);

    x = x + v*deltaTime;
    alpha = GetSlopeAngle(x, iSlope, iDataSet);

    forceGravity = ForceGravity(forceGravity, mass, gravity, alpha);
    forceEB = EngineBrakes(cb, gear);
    brakeTemp = UpdateBrakeTemperature(brakeTemp, ambientTemp, deltaTime, ch, tau, pedalPressure, lowBrakePressure);
    forceFB = FoundationBrakes(mass, pedalPressure, brakeTemp, maxTemp, gravity);

    vDot = Acceleration(vDot, mass, forceGravity, forceFB, forceEB);
    v = v + vDot*deltaTime;

    networkInput = [v/vMax; alpha/alphaMax; brakeTemp/maxTemp; 1];
end
fitness = ComputeFitness(x, xMax, v, vMax, iDrive);
end