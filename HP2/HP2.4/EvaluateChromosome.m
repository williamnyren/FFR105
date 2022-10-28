function [fitness, error] = EvaluateChromosome(chromosome, xData, yData, constantRegister, variableRegisterRange, mMax)
yDataFit = zeros(size(yData));

for x = 1:length(xData)-1
    yDataFit(i) = ChromosomeToInstrunctions(chromosome, xData(i+1)+xData(i), constantRegister, variableRegisterRange);
end
chromosomeLength = length(chromosome);
if (chromosomeLength >= mMax)
    penaltyFactor = 1/(1+exp(10*(chromosomeLength-mMax)/mMax));
else
    penaltyFactor = 1;
end
slope = (yData(2:end) - yData(1:end-1))./(xData(2:end) - xData(1:end-1));   
error = rms(yDataFit - yData);
fitness = penaltyFactor/error;
end