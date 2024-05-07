function result = ONEFS(M,Range,Rank, coeffq, flavexpr, normalise_z)
    syms q y1 y2 y3 yf
    list = graphOrdering(M);

    sizes = size(M);
    n = sizes(1);   
    %coeffq = ;
    out = rearrangeflavourexpression(flavexpr);
    newout = returnkili(out);
    newout = str2sym(newout);
    coeffz = newout * normalise_z;
    disp(coeffz);
    array = returnkrondet(out);
    [rows, cols] = size(array);
    
    modifiedArray = cell(rows, cols); 

    for i = 1:rows
        for j = 1:cols
            modifiedArray{i, j} = changeflavour(array(i, j), n);
        end
    end
    generateFunctionONEFS(M,list,Range, coeffq, coeffz, modifiedArray);
    res(q) = hardcoded_generalfuncONEFS(Range);
    %res(q) = hardcoded1flavour(Range);
    tay = taylor_series(res,Range);
    qinfnew = qinf^Rank;
    fin = multiply(qinfnew, tay);
    result = rewrite(fin, Range);
    disp(result);
