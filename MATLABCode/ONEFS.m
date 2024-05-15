function result = ONEFS(M,Range,Rank)
    syms q z1
    
    res(q) = mainfunc();
    tay = taylor_series(res,Range);
    qinfnew = qinf^Rank;
    fin = multiply(qinfnew, tay);
    result = rewrite(fin, Range);
    disp(result);
