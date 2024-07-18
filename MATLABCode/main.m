tic; 

Range = 4;
dimension = 7; 
random = true;
maxMatrices = 5000;

%matrices = generateAdjacencyMatrices(dimension,random,maxMatrices);

%load('matrices_progress.mat', 'matrices'); 
%disp(matrices);

fileName = "SchurIndexList7Nodes.txt";
numMatricesToProcess = size(matrices,3);
savetofile(matrices, Range, numMatricesToProcess, fileName);
%DeriveSchurIndexWL(matrices(:,:,1),Range);

toc;