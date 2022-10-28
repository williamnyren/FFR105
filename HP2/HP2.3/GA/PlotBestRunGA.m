function [] = PlotBestRunGA(bestFitnessListTraning, bestFitnessListValidation)
bestFitnessListTraning = bestFitnessListTraning(~isnan(bestFitnessListTraning));
plot(1:length(bestFitnessListTraning), bestFitnessListTraning, 'b-')
xlabel('Generation')
ylabel('Max Fitness')
title('Overfitting detection')
axis([0 2500 0.3 0.5])
hold on
grid on
bestFitnessListValidation = bestFitnessListValidation(~isnan(bestFitnessListValidation));
plot(1:length(bestFitnessListValidation), bestFitnessListValidation, 'r-')
end