function generateMainFuncWLNFS(M,Range,Rank, inputList)
    len = size(M,1);
    swaps = countswaps(M, inputList);
    swapsnew = changeflavourWLNFS(swaps);
    [varString, rangeString] = generateLstrings(len);

    scriptContent = {
        'ClearAll[q, result]'
        'q = Symbol["q"];'
        'ClearAll[qPochhammer];'
        'qPochhammer[q_, n_] := '
        ' qPochhammer[q, n] = If[n == 0, 1, Product[(1 - q^k), {k, 1, n}]]'
        ''
        sprintf('range = Range[0, %d];',Range)
        ''
        ''
        '(*Compute the sum using Table for efficiency and memoized calculations*)'
        'terms = Table['
        '   Module[{l,sumExponent, denominator, expr},'
        sprintf('    l = {%s};',varString)
        sprintf('     sumExponent = (Total[l]) + %s;',swapsnew)
        '     denominator = Times @@ ((qPochhammer[q, #])^2 & /@ l);'
        '     expr = (q^sumExponent)/denominator;'
        '     expr'
        sprintf('    ], %s];', rangeString)
        'result = Total[Flatten[terms]];'
        ''
        sprintf('taylorSeries = Series[result, {q, 0, %d}];',Range)
        ''
        '(*Convert the series to normal polynomial form, truncating higher-order terms*)'
        'truncatedResult = Normal[taylorSeries];'
        ''
        'qinf[q_] = '
        '  1 - 2*q - q^2 + 2*q^3 + q^4 + 2*q^5 - 2*q^6 - 2*q^8 - 2*q^9 + q^10 + 2*q^13 + 3*q^14 - 2*q^15 + 2*q^16 - 2*q^19 - 2*q^20;'
        sprintf('series2 = qinf[q]^%d;',Rank)
        'product = truncatedResult*series2;'
        'expandedProduct = Expand[product];'
        sprintf('truncatedResult2 = Normal[Series[expandedProduct, {q, 0, %d}]];',Range)
        'Print[truncatedResult2];'
    };

    % Open the file for writing
    fid = fopen('scriptNFS.wl', 'w');
    
    % Handle error in file opening
    if fid == -1
        error('Failed to open file for writing.');
    end
    
    % Write each line of the script content to the file
    for i = 1:length(scriptContent)
        fprintf(fid, '%s\n', scriptContent{i});
    end

    % Close the file
    fclose(fid);

end


