function result = ONEFSarray(M,Range,Rank, coeffqarray, flavexpr, normalise_z)
    syms l1 l2 l3 k1 k2 k3 yf y1 y2 y3 l q
    
    list = graphOrdering(M);
    
    sizes = size(M);
    n = sizes(1);
    
    expressionarray = rearrangefearrayONEFS(flavexpr);
    coeffzarray = returnkiliarray(expressionarray);
    krondetarray = returnkrondetarray(expressionarray);
    
    for t = 1:n
        coeffqarray{t} = changeflavour(coeffqarray{t},n);
        coeffzarray{t} = changeflavour(coeffzarray{t},n);
        krondetarray{t} = changeflavour(krondetarray{t},n);
    end
    
    for i = 1:n
        generateFunctionONEFS(M, list, 1, coeffqarray{i}, coeffzarray{i}, krondetarray{i},normalise_z);
        res(q) = hardcoded_generalfuncONEFS(1); 
        tay = taylor_series(res, 1); 
        qinfnew = qinf^Rank; 
        fin = multiply(qinfnew, tay);
        result = rewrite(fin, 1);
        coeffsArray = coeffs(result, q);
    
        if length(coeffsArray) > 1 && coeffsArray(2) == 1 % Assuming the linear term is the second element
            disp(['The correct gamma term is: ', num2str(i)]);
            correctval = i;
            break;
        end
        disp(['Checked gamma term: ', num2str(i)])
    end
    generateFunctionONEFS(M, list, Range, coeffqarray{correctval}, coeffzarray{correctval}, krondetarray{correctval},normalise_z);
    res(q) = hardcoded_generalfuncONEFS(Range); 
    %res(q) = hardcoded1flavourNEW(Range);
    tay = taylor_series(res, Range); 
    disp(tay);
    qinfnew = qinf^Rank; 
    fin = multiply(qinfnew, tay);
    result = rewrite(fin, Range);
end

