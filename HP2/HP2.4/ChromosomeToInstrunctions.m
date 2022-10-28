function result = ChromosomeToInstrunctions(chromosome, x, constantRegister, variableRegisterRange)

variableRegister = zeros(1, variableRegisterRange);
variableRegister(1) = x;

register = [variableRegister, constantRegister];

chromosomeLength = length(chromosome);
numGenes = chromosomeLength/4;
genes = reshape(chromosome, 4, []);

for i = 1:numGenes
    operator = genes(1, i);
    destination = genes(2, i);
    operand1 = genes(3, i);
    operand2 = genes(4, i);

    if operator == 1 % +
        register(destination) = register(operand1) + register(operand2);
    elseif operator == 2  % -
        register(destination) = register(operand1) - register(operand2);
    elseif operator == 3  % *
        register(destination) = register(operand1) * register(operand2);
    elseif operator == 4  % /
        if (register(operand2) == 0)
            register(destination) = 1e16;
        else
            register(destination) = register(operand1)/register(operand2);
        end

    end
    result = register(1);
end