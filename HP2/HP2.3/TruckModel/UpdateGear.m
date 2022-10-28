function [gear, gearIter] = UpdateGear(gear, shiftGearSignal, gearIter, gearIterDelay, gearEncodingLow, gearEncodingHigh)
gearIter = gearIter + 1;
if (mod(gearIter, gearIterDelay) == 0)
    gear = gear - sign(shiftGearSignal-gearEncodingLow)*...
        ((shiftGearSignal > gearEncodingHigh)+(shiftGearSignal < gearEncodingLow));
    gear = max(gear, 1);
    gear = min(gear, 10);
    gearIter = 0;
end
end