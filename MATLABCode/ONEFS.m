function result = ONEFS(M,Range,Rank)
    plotgraph(M);
    syms q 
    generateMainFunc(M,Range)
    res(q) = mainfunc();
    tay = taylor_series(res,Range);
    qinfnew = qinf^Rank;
    fin = multiply(qinfnew, tay);
    result = rewrite(fin, Range);
    fprintf('\n')
    disp(['Schur index for M = ', mat2str(M)]);
    disp(result);
    disp('Unrefined Schur index:');
    disp(countTerms(result));
