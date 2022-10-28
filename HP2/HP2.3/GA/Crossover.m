function [c1, c2] = Crossover(c1, c2)
    crossIndex = randi(length(c1)-1);
    cTemp = c2;
    c2(1:crossIndex) = c1(1:crossIndex);
    c1(1:crossIndex) = cTemp(1:crossIndex);
end