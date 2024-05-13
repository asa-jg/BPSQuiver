% Define an antisymmetric matrix with a guaranteed null space of dimension >= 2
M1 = [0 -1 -1 -1 -1; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0;];
M2 = [0 0 -1 -1; 0 0 -1 -1; 1 1 0 0; 1 1 0 0];
M3 = [0 1 1; -1 0 -1; -1 1 0;];

Y = deriveflavourvector(M3, true);
disp('Independent solution vectors:');
disp(Y);


M1 = [0 -1 -1 -1 -1; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0];
[modifiedVectors, indicesAndCoeffs] = processSolutionVectors(M1);

disp('Modified Vectors:');
disp(modifiedVectors);

M1 = [0 -1 -1 -1 -1; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0];
FinalOrdering = mainFunction(M1);
