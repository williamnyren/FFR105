function [] = PlotTruckPath(tripLog, iSlope, iDataSet)
[maxTemp, ~, ~, ~, ambientTemp, ~, vMax, ~,...
    alphaMax, ~, xMax, ~, ~,...
    ~, ~, ~, ~, ~, ~, ~,...
    ~, ~,~, ~, ~] = SimulationParameters(iSlope, iDataSet);
fig = figure(iSlope);
fig.WindowState = 'maximized';

x = tripLog(6, :);
alpha = tripLog(1, :);
pedalPressure = tripLog(2, :);
gear = tripLog(3, :);
v = tripLog(4, :);
brakeTemp = tripLog(5, :);

subplot(5,1,1)
plot(x, alpha, '-')
xlabel('x', 'Interpreter','latex')
ylabel('$$\alpha$$ (Degrees)',  'FontSize', 18,'Interpreter','latex')
title('Trip log','FontSize', 24, 'Interpreter','latex')
grid on
yline(10)
yline(0)
axis([0 xMax 0 alphaMax])

% figure(slope);
subplot(5,1,2)
plot(x, pedalPressure, '-')
xlabel('x', 'Interpreter','latex')
ylabel('$$P_p$$ (Pedal Pressure)', 'FontSize', 18,'Interpreter','latex')
grid on
maximumPedalPressure = max(max(tripLog(2, :, :)));
axis([0 xMax 0 1.05*maximumPedalPressure]);

% figure(slope);
subplot(5,1,3)
plot(x, gear, '-')
xlabel('x', 'Interpreter','latex')
ylabel('gear', 'FontSize', 18, 'Interpreter','latex')
grid on
yline(10)
yline(1)
axis([0 xMax 1 10])

% figure(slope);
subplot(5,1,4)
plot(x, v, '-')
xlabel('x', 'Interpreter','latex')
ylabel('$$\mathcal{V}$$ [m/s]', 'FontSize', 18, 'Interpreter','latex')
grid on
yline(25)
yline(1)
axis([0 xMax 1 vMax])

% figure(slope);
subplot(5,1,5)
plot(x, brakeTemp, '-')
xlabel('x', 'FontSize', 18, 'Interpreter','latex')
ylabel('$$T_b$$ (Brake Temp.) [K]', 'FontSize', 18, 'Interpreter','latex')
grid on
yline(maxTemp)
yline(ambientTemp)
axis([0 xMax ambientTemp maxTemp])
shg
end