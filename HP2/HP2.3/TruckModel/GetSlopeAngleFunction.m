% This function was made to increase computation speed while training. All slopes and
% data-sets are exactly the same as in GetSlopeAngle.m.
%Insted of returning a value alpha, a function handle is returned at the
%start of EvaluateTrucker.m
function SlopeFunction = GetSlopeAngleFunction(iSlope, iDataSet)

switch iDataSet
    case 1  % Training
        switch iSlope
            case 1
                SlopeFunction =@(x)2.8799  -0.25535*sin(x./30.8389) + 0.1763*cos(0.66835*x./266.5309) + 1.488*cos(x./215.2128) -0.48783*sin(1.9303*x./242.2153);
            case 2
                SlopeFunction =@(x)3 + 2*sin(x/50) + cos(sqrt(2)*x/100);
            case 3
                SlopeFunction =@(x)4.4632 + 0.32564*sin(x./208.9762) -1.8405*cos(2.4268*x./310.4351) -1.7246*cos(x./86.7237) + 2.9657*sin(2.438*x./218.0002);
            case 4
                SlopeFunction =@(x)5 + sin(x/50) + cos(sqrt(5)*x/50);
            case 5
                SlopeFunction =@(x)4.7758+ 0.8248*sin(x./263.092)+ 0.70068*cos(2.0095*x./86.7708)-0.21675*cos(x./408.0798)+ 3.6625*sin(2.2561*x./226.6167);
            case 6
                SlopeFunction =@(x)4.6922 + 1.7018*sin(x./308.0075) + 0.96834*cos(2.0971*x./304.0253) -1.0051*cos(x./29.3721) + 1.2987*sin(2.0366*x./149.9536);
            case 7
                SlopeFunction =@(x)4.5177 + 0.65736*sin(x./93.1216) -0.61305*cos(0.6954*x./16.1513) -0.00071747*cos(x./125.4874) -1.6954*sin(1.425*x./116.8199);
            case 8
                SlopeFunction =@(x)6 - sin(x/100) + cos(sqrt(3)*x/50);
            case 9
                SlopeFunction =@(x)2.8462 -0.063784*sin(x./141.2717) + 0.39838*cos(1.7918*x./145.1518) + 0.58654*cos(x./121.1059) + 0.86876*sin(1.054*x./140.6405);
            case 10
                SlopeFunction =@(x)4 + sin(x/100) + cos(sqrt(2)*x/50);
            otherwise
                warning('Unexpected type.')
        end
    case 2  % Validation
        switch iSlope
            case 1
                SlopeFunction =@(x)4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100);
            case 2
                SlopeFunction =@(x)4.2921 -0.91077*sin(x./149.128) + 1.202*cos(2.0411*x./105.3271) + 2.1303*cos(x./151.1337) + 2.5956*sin(2.3486*x./140.4401);
            case 3
                SlopeFunction =@(x)3.8239 -0.68341*sin(x./371.2403) + 0.25549*cos(1.2425*x./32.6381) + 0.98838*cos(x./79.8835) -1.6792*sin(1.6892*x./438.4645);

            case 4
                SlopeFunction =@(x)5.2944 + 0.59529*sin(x./110.878) -0.56002*cos(0.49114*x./115.3451) + 0.81506*cos(x./58.0064) -1.0583*sin(1.2555*x./50.2116);
            case 5
                SlopeFunction =@(x)1.6965 + 3.3276*sin(x./294.2182) + 0.72749*cos(1.1297*x./62.3927) + 1.7463*cos(x./285.9466) + 3.5146*sin(0.94259*x./347.8474);
            otherwise
                warning('Unexpected type.')
        end
    case 3  % Test
        switch iSlope
            case 1
                SlopeFunction =@(x)6.5267 -2.4513*sin(x./354.3917) -2.22433*cos(2.0894*x./57.9433) + 1.801*cos(x./17.0667) + 0.63927*sin(0.56543*x./900.4264);
            case 2
                SlopeFunction =@(x)2.1429 -0.773*sin(x./93.4854) + 0.39478*cos(1.0374*x./87.6307) -0.11211*cos(x./153.0486) + 0.41937*sin(1.24*x./49.4801);
            case 3
                SlopeFunction =@(x)5.6792 -2.2495*sin(x./112.3875) + 1.8946*cos(0.5401*x./12.4532) + 0.68097*cos(x./36.6204) + 0.93384*sin(1.2389*x./97.7917);
            case 4
                SlopeFunction =@(x)4.7888 + 0.80634*sin(x./195.2094)  -0.18112*cos(0.86104*x./298.5452) + 1.3305*cos(x./45.7565)  -0.86051*sin(1.8924*x./48.4041);
            case 5
                SlopeFunction =@(x)2.9891 + 0.71923*sin(x./291.1495) -0.67378*cos(1.3997*x./282.7254) + 0.30002*cos(x./322.7247) -0.32954*sin(1.693*x./87.1746);
            otherwise
                warning('Unexpected type.')
        end
end
end
