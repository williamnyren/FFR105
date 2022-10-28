% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.

function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)
    
    gradF = ComputeGradient(xStart, mu);
    x = xStart-eta*gradF;
    while norm(gradF) >= gradientTolerance
        gradF = ComputeGradient(x, mu);
        x = x-eta*gradF;
    end
end