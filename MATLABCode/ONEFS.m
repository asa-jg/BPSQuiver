function [refined, unrefined] = ONEFS(M,Range,Rank)
    plotgraph(M);
    syms q 
    generateMainFunc(M,Range)
    res(q) = mainfunc();
    tay = taylor_series(res,Range);
    qinfnew = qinf^Rank;
    fin = multiply(qinfnew, tay);
    refined = rewrite(fin, Range);
    fprintf('\n')
    disp(['Schur index for M = ', mat2str(M)]);
    disp(refined);
    disp('Unrefined Schur index:');
    unrefined = countTerms(refined);
    disp((unrefined));
    
