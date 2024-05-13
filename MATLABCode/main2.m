tic;
% Define an antisymmetric matrix with a guaranteed null space of dimension >= 2
M1 = [0 -1 -1 -1 -1; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0;];
M2 = [0 0 -1 -1; 0 0 -1 -1; 1 1 0 0; 1 1 0 0];
M3 = [0 1 1; -1 0 -1; -1 1 0;];

M = M3;

[modifiedVectors, indicesAndCoeffs] = processSolutionVectors(M);
Y = deriveflavourvector(M, true);
disp('Independent solution vectors:');
disp(Y);

disp('Modified Vectors:');
disp(modifiedVectors);

FinalOrdering = createFinalOrder(M);

TARGET = graphOrderingFS(M);
bubble(FinalOrdering, TARGET, M);

toc;
