function [maxTemp, mass, tau, ch, ambientTemp, cb, vMax, vMin,...
    alphaMax, deltaTime, xMax, gravity, lowBrakePressure,...
    gearEncodingHigh, gearEncodingLow, x, v, vDot, alpha, brakeTemp,...
    pedalPressure, gear,forceGravity, forceEB, forceFB] = SimulationParameters(iSlope, iDataSet)

maxTemp = 750; % K
mass = 20e3; % Kg
tau = 30; % s
ch = 40; % K/s;
ambientTemp = 283; % K
cb = 3e3; % N
vMax = 25; % m/s
vMin = 1; % m/s
alphaMax = 10; % degrees
deltaTime = 0.2;
xMax = 1000;
gravity = 9.81; % Nm/s^2
lowBrakePressure = 0.01;

gearEncodingHigh = 1./(1 + exp(-0.7));
gearEncodingLow = 1./(1 + exp(0.7));

% Initial conditions
x = 0;
v = 20;
vDot = 0;
alpha = GetSlopeAngle(0, iSlope, iDataSet);
brakeTemp = 500;
pedalPressure = 0;
gear = 7;
forceGravity = ForceGravity(0, mass, gravity, alpha);
forceEB = EngineBrakes(cb, gear);
forceFB = FoundationBrakes(mass, pedalPressure, brakeTemp, maxTemp, gravity);
vDot = Acceleration(vDot, mass, forceGravity, forceFB, forceEB);