tic;
M1 = [0 -1 -1 -1 -1; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0;];
M2 = [0 0 -1 -1; 0 0 -1 -1; 1 1 0 0; 1 1 0 0];
M3 = [0 1 1; -1 0 -1; -1 1 0;];
M4 = [0 2; -2 0];
M5 = [0 1 0 0 0 0 0; -1 0 -1 0 0 0 0; 0 1 0 1 0 0 0; 0 0 -1 0 -1 0 0; 0 0 0 1 0 1 0; 0 0 0 0 -1 0 -1; 0 0 0 0 0 1 0];
M6 = [0 0 1; 0 0 1; -1 -1 0];
M7 = [0 1 0; -1 0 -1; 0 1 0;];
M8 = [0 1 0 0 0; -1 0 -1 0 0; 0 1 0 1 0; 0 0 -1 0 -1; 0 0 0 1 0];
M9 = [0 1 0 0; -1 0 -1 -1; 0 1 0 0; 0 1 0 0];


Range = 10;
dimension = 3;
matrices = generateAdjacencyMatrices(dimension);
%numMatrices = size(matrices, 3);
%for i = 1:numMatrices
%    M = matrices(:, :, i);
%    [result, unrefined] = DeriveSchurIndex(M,Range);
%    appendDataToFile(M,result, unrefined);
%end


plotgraph(matrices(:,:,1));

toc;