x = randi([-5, 5], 1, 100);
y = randi([-5, 5], 1, 100);

[X, Y, Z] = ProduceData(x, y);

surf(Z)