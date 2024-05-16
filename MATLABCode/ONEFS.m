function result = ONEFS(M,Range,Rank)
    plotgraph(M);
    syms q z1
    generateMainFunc(M,Range)
    res(q) = mainfunc();
    tay = taylor_series(res,Range);
    qinfnew = qinf^Rank;
    fin = multiply(qinfnew, tay);
    result = rewrite(fin, Range);
    disp(['Schur index for M = ', mat2str(M)]);
    disp(result);
