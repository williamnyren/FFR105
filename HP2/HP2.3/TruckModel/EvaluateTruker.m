function fitness = EvaluateTruker(network, iSlope, iDataSet)
% Initiate parameters and initial conditions.
[maxTemp, mass, tau, ch, ambientTemp, cb, vMax, vMin,...
    alphaMax, deltaTime, xMax, gravity, lowBrakePressure,...
    gearEncodingHigh, gearEncodingLow, x, v, vDot, alpha, brakeTemp,...
    pedalPressure, gear,forceGravity, forceEB, forceFB] = SimulationParameters(iSlope, iDataSet);

% Load relevant slope function once with a function handle!
SlopeFunction = GetSlopeAngleFunction(iSlope, iDataSet);

% To compute avg(v) as (v(1)+...v(#iterations))/#Iterations
vMean = v;

% Minimum number of iterations between gear shifts
gearIterDelay = ceil(2/deltaTime);
gearIter =  gearIterDelay -1;

wIH = network.wIH;
wHO = network.wHO;
% Append element "1" to include bias term
networkInput = [v/vMax; alpha/alphaMax; brakeTemp/maxTemp; 1];

numMaxIters = ceil((vMin/deltaTime)*xMax);
for iDrive = 1:numMaxIters
    booleanBreak = (xMax <= x) + (v < vMin)  + (max(networkInput) > 1);
    if booleanBreak > 0
        break
    end
    [pedalPressure, shiftGearSignal] = RunFFNN(networkInput, wIH, wHO );
    [gear, gearIter] = UpdateGear(gear, shiftGearSignal, gearIter, gearIterDelay, gearEncodingLow, gearEncodingHigh);

    x = x + v*deltaTime;
    alpha = SlopeFunction(x);

    forceGravity = ForceGravity(forceGravity, mass, gravity, alpha);
    forceEB = EngineBrakes(cb, gear);
    brakeTemp = UpdateBrakeTemperature(brakeTemp, ambientTemp, deltaTime, ch, tau, pedalPressure, lowBrakePressure);
    forceFB = FoundationBrakes(mass, pedalPressure, brakeTemp, maxTemp, gravity);

    vDot = Acceleration(vDot, mass, forceGravity, forceFB, forceEB);
    v = v + vDot*deltaTime;

    networkInput = [v/vMax; alpha/alphaMax; brakeTemp/maxTemp; 1];
    vMean = vMean + v;
end

fitness = ComputeFitness(x, xMax, v, vMax, iDrive);

end