tic;
M1 = [0 0 1 0 0 0; 0 0 1 0 0 0; -1 -1 0 1 0 0; 0 0 -1 0 1 1; 0 0 0 -1 0 0; 0 0 0 -1 0 0];
M2 = [0 0 -1 -1; 0 0 -1 -1; 1 1 0 0; 1 1 0 0];
M3 = [0 0 -1 -1; 0 0 1 1; 1 -1 0 0; 1 -1 0 0];
M4 = [0 -1 -1 -1 -1; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0];

Range = 4;
M = M4;
dimension = 5; 

%DeriveSchurIndexWL(M,Range);

%matrices5d = generateAdjacencyMatrices(dimension); 
%disp(matrices5d(:,:,26430))

numMatricesToProcess = 26430;
range = 4;
savetofile(matrices5d, Range, numMatricesToProcess);
 
toc;