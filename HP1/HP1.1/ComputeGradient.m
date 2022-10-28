% This function should return the gradient of f_p = f + penalty.
% You may hard-code the gradient required for this specific problem.

function gradF = ComputeGradient(x, mu)
    p = max((sum(x.^2) -1), 0);
    muBoolean = mu*sign(p);

    gradFx = 2*(x(1)-1) + 4*muBoolean*x(1)*(sum(x.^2)-1);
    gradFy = 4*(x(2)-2) + 4*muBoolean*x(2)*(sum(x.^2)-1);

    gradF = [gradFx, gradFy];

end