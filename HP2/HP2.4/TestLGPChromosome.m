clf;
clc;
% bestChromosome = BestChromosome();
% constantRegister = ConstantRegister();
variableRegisterRange = 4;
data = LoadFunctionData;
xData = data(:, 1);
yData = data(:, 2);
lengthData = length(yData);
yFit = zeros(lengthData, 1);
for i = 1:lengthData
    yFit(i) = ChromosomeToInstrunctions(bestChromosome, xData(i), constantRegister, variableRegisterRange);
end



plot(xData, yData, 'r', 'LineWidth',5.5);
title("Curve fitting")
hold on;
plot(xData, yFit, 'k.-');
legend('data', '$$\frac{(x^3 - x^2 + 1/3)}{(x^4 - x^2 + 1)}$$','FontSize', 18, 'Interpreter','Latex')
ylabel('y', 'FontSize', 18,'Interpreter','latex')
xlabel('x', 'FontSize', 18,'Interpreter','latex')
grid on

operatorRange = 4; %{+, -, *, /}
variableRegisterRange = 4;
constantRegisterRange = 6;

constantRegister = [1 2 3 4 5 6];

constantRegisterAsChar = string(constantRegister);
variableRegister = zeros(1, variableRegisterRange);
variableRegisterAsChar = string(variableRegister);
variableRegisterAsChar(1) ="x";

registers = [variableRegisterAsChar, constantRegisterAsChar];
operators = ["+", "-", "*", "/"];

chromosomeLength = length(bestChromosome);
numGenes = chromosomeLength/4;
genes = reshape(bestChromosome, 4, []);

for i = 1:numGenes
    operator = genes(1, i);
    destination = genes(2, i);
    operand1 = genes(3, i);
    operand2 = genes(4, i);
    
    registers(destination) = "(" + registers(operand1) + operators(operator) + registers(operand2) + ")";

end
disp(['Error_rms= ', num2str(rms(yFit - yData))]);
str = registers(1);
disp(['Chromosome output: ', str])
y = str2sym(str);
SimplifiedOutput = simplify(y,'Steps',25)
