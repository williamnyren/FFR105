% nIn = the number of inputs
% nHidden = the number of hidden neurons
% nOut = the number of output neurons
% Weights (and biases) should take values in the range [-wMax,wMax]

function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax)
chromosome = chromosome*wMax;

wIH = zeros(nHidden, nIn+1);
for iHidden = 1:nHidden
    rowEnd = iHidden*(nIn+1);
    rowStart = rowEnd - (nIn + 1) + 1;
    wIH(iHidden, :) = chromosome(rowStart:rowEnd);
end

splitLayerIndex = (nIn+1)*nHidden;
wHO = zeros(nOut, nHidden+1);
for iOut = 1:nOut
    rowStart = splitLayerIndex + 1 + (iOut -1)*(nHidden + 1);
    rowEnd = rowStart+nHidden;
    wHO(iOut, :) = chromosome(rowStart:rowEnd);
end

end