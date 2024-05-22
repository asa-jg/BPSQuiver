M1 = [0 -1 -1 -1 -1; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0;];
M = M1;

[modifiedVectors, indicesAndCoeffs, isSuccess] = processSolutionVectors2(M,3);
disp(modifiedVectors);
disp(indicesAndCoeffs);
createFinalOrder2(M);