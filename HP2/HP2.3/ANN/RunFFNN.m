function [pedalPressure, shiftGearSignal] = RunFFNN(networkInput, wIH, wHO)
hiddenNeurons = wIH*networkInput;
% Activation function
hiddenNeurons = 1./(1 + exp(-hiddenNeurons));
% Append element "1" to include bias term
networkOutput = wHO*[hiddenNeurons; 1];
% Activation function
networkOutput = 1./(1 + exp(-networkOutput));
pedalPressure = networkOutput(1);
shiftGearSignal = networkOutput(2);
end