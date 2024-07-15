tic; 

Range = 4;
M = M5;
dimension = 6; 
random = true;
maxMatrices = 5647; 

%matrices6 = generateAdjacencyMatrices(dimension, random, maxMatrices); 
load('matrices_progress.mat', 'matrices'); 

fileName = "SchurIndexList6Nodes.txt";
numMatricesToProcess = size(matrices,3);
savetofile(matrices, Range, numMatricesToProcess, fileName);

toc;