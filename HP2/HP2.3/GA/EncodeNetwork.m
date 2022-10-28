function chromosome = EncodeNetwork(wIH, wHO, wMax)
    wIH = wIH./wMax;
    wHO = wHO./wMax;

    chromosome = [reshape(wIH', [], 1); reshape(wHO', [], 1)];
end
    



