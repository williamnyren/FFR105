function [newChromosome1, newChromosome2, newChromosomeLength1, newChromosomeLength2] = TwoPointCross(chromosome1, chromosome2)

chromosomeLength1 = length(chromosome1);
chromosomeLength2 = length(chromosome2);    

geneEdges1 = 1:4:chromosomeLength1;
geneEdges2 = 1:4:chromosomeLength2;

indexSamplePool1 = length(geneEdges1);
indexSamplePool2 = length(geneEdges2);

indexGeneEdges1 = randperm(indexSamplePool1, 2);
indexGeneEdges2 = randperm(indexSamplePool2, 2);

loIndexEdge1 = min(geneEdges1(indexGeneEdges1));
hiIndexEdge1 = max(geneEdges1(indexGeneEdges1));
swapSectionLength1 = hiIndexEdge1 - loIndexEdge1;

loIndexEdge2 = min(geneEdges2(indexGeneEdges2));
hiIndexEdge2 = max(geneEdges2(indexGeneEdges2));
swapSectionLength2 = hiIndexEdge2 - loIndexEdge2;

newChromosomeLength1 = chromosomeLength1 - swapSectionLength1 + swapSectionLength2;
newChromosomeLength2 = chromosomeLength2 - swapSectionLength2 + swapSectionLength1;

newChromosome1 = [chromosome1(1:loIndexEdge1-1);
    chromosome2(loIndexEdge2:hiIndexEdge2-1);
    chromosome1(hiIndexEdge1:end)];

newChromosome2 = [chromosome2(1:loIndexEdge2-1);
    chromosome1(loIndexEdge1:hiIndexEdge1-1);
    chromosome2(hiIndexEdge2:end)];
end 