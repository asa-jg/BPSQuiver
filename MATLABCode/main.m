M3 = [0 1 1; -1 0 -1; -1 1 0;];
M = M3;
inputList = graphOrdering(M);
disp(countswaps(M, inputList));