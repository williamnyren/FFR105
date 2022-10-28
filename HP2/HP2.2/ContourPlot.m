
mat = dir('*.mat');
fileCount = 0;
for q = 1:length(mat)
    fileCount = fileCount + 1;
    contMat = load(mat(q).name);
    contCell = struct2cell(contMat);
    bestDataPoint(fileCount, :) = contCell{1};
end

xMinG = -5; xMaxG = 5;
x = linspace(xMinG, xMaxG, 500);
y = linspace(xMinG, xMaxG, 500);

[X, Y] = meshgrid(x, y);
Z = LogFunction(X, Y);
[M, c] = contour(X, Y, Z, 10, '--');
c.LineWidth = 2;

axis([xMinG xMaxG xMinG xMaxG])
hold on
grid on
for i = 1:size(bestDataPoint, 1)
    xBest = bestDataPoint(i, 1);
    yBest = bestDataPoint(i, 2);
    plotScale = 2e2;
    s = scatter(xBest, yBest, plotScale);
    s.LineWidth = 3.5;
    s.MarkerEdgeColor = 'k';
    s.MarkerFaceColor = [1 1 0];
end
xlabel('$$x$$','interpreter','latex');
ylabel('$$y$$','interpreter','latex');
t = title('Isolines to $$log(0.1 + f(x,y))$$','interpreter','latex');
