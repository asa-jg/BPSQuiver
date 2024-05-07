tic;
syms l1 l2 l3 k1 k2 k3 yf y1 y2 y3 


adjMatrix1 = [0 1 0 0; 0 0 0 0; 0 1 0 1; 0 0 0 0];
adjMatrix2 = [0 3; 0 0];
adjMatrix3 = [0 2; -2 0];
adjMatrix4 = [0 1 1; -1 0 -1; -1 1 0;];
adjMatrix5 = [0 0 0 0; 0 0 0 0; 1 1 0 0; 1 1 0 0;];

M = adjMatrix3;
Range = 10;
Rank = 1;
list = graphOrdering(M);
flavexpr = yf == y1 + y2 - y3;
normalise_z = 2;
t = 3;
coeffqarray = {-1/2*(k1 - l1)^2 -1/2*(k2 - l2)^2 -1/2*(k3 - l3)^2};
%coeffqarray = {sym(0) sym(0) sym(0)};

plotgraph(M);
                                                                                                        
%ONEFSarray(M,Range,Rank, coeffqarray, flavexpr, normalise_z)
NFS(M,Range,Rank)

toc;