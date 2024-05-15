tic;
% Define an antisymmetric matrix with a guaranteed null space of dimension >= 2
M1 = [0 -1 -1 -1 -1; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0;];
M2 = [0 0 -1 -1; 0 0 -1 -1; 1 1 0 0; 1 1 0 0];
M3 = [0 1 1; -1 0 -1; -1 1 0;];
M4 = [0 1 0; -1 0 -1; 0 1 0];
%M4 = [0 2; -2 0];

M = M2;

%mainloop(M);

%disp("loop done");


[modifiedVectors, indicesAndCoeffs] = processSolutionVectors(M);
columnVector = indicesAndCoeffs(:,2);
indices = columnVector.'; 

%result = convertflavexpr(M, indices, modifiedVectors);
result = superloop(M);
% Display the results
%disp(result);
toc;
