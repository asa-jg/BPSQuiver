% Define an antisymmetric matrix with a guaranteed null space of dimension >= 2
M1 = [0 -1 -1 -1 -1; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0;];
M2 = [0 0 -1 -1; 0 0 -1 -1; 1 1 0 0; 1 1 0 0];
plotgraph(M2);
Y = solveLinearSystem(M2);
disp('Independent solution vectors:');
disp(Y);