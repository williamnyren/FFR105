% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome, numberOfVariables, maximumVariableValue);
    numberOfEncodingBits = length(chromosome)/numberOfVariables;
    scalingFactor = 2*maximumVariableValue/(1-2^(-numberOfEncodingBits));
    decodeBase = 2.^(-(1:1:numberOfEncodingBits));
    
    chromosome = reshape(chromosome, [numberOfEncodingBits, numberOfVariables]);
    x = -maximumVariableValue + scalingFactor*decodeBase*chromosome;
end

