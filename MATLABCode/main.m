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

M = M9;
Range = 2;
Rank = 1;   
syms q z1 z2 z3;
DeriveSchurIndex(M,Range,Rank);

%disp(countTerms(expr)); 

%disp(graphOrdering(M));

toc;