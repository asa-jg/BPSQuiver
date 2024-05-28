function generateMainFuncWL(M,Range,Rank)
    len = size(M,1);
    [qresult, zresult, newkron1] = superloop(M);
    newkron = changeflavourWL(newkron1,len);
    newkron = newkron(3:end);
    qresultnew = changeflavourWL(qresult,len);
    zresultnew = changeflavourWL(zresult,len);
    
    %[varStr, rangeStr] = generateLstrings(len);
    %disp(varStr);
    %disp(rangeStr);


    scriptContent = {
        '(*Define symbolic variables*)ClearAll[q, z1, z2, z3, z4, z5, result]'
        'q = Symbol["q"];'
        'z1 = Symbol["z1"];'
        'z2 = Symbol["z2"];'
        'z3 = Symbol["z3"];'
        'z4 = Symbol["z4"];'
        'z5 = Symbol["z5"];'
        ''
        '(*Define memoized q-Pochhammer function*)'
        'ClearAll[qPochhammer];'
        'qPochhammer[q_, n_] := '
        ' qPochhammer[q, n] = If[n == 0, 1, Product[(1 - q^k), {k, 1, n}]]'
        ''
        '(*Range for summation indices*)'
        sprintf('range = Range[0, %d];',Range)
        ''
        '(*Generate all valid combinations recursively*)'
        'ClearAll[generateCombinations];'
        'generateCombinations[n_, max_, sumLimit_, prefix_ : {}] := '
        '  If[n == 0, {prefix}, '
        '   Flatten[Table['
        '     If[Total[prefix] + i < sumLimit, '
        '      generateCombinations[n - 1, max, sumLimit, '
        '       Append[prefix, i]], {}], {i, 0, max}], 1]];'
        ''
        sprintf('combinations = generateCombinations[%d, %d, %d];',2*len,Range,2*Range+2)
        ''
        '(*Compute the sum using Table for efficiency and memoized calculations*)'
        'terms = Table['
        '   Module[{l, sumExponent, zTerm, denominator, expr}, l = comb;'
        '    (*Check the conditions*)'
        sprintf('    If [%s,', newkron)
        sprintf('    sumExponent = 1/2 (Total[l]) + %s;',qresultnew)
        sprintf('    zTerm = %s;', zresultnew)
        '     denominator = Times @@ (qPochhammer[q, #] & /@ l);'
        '     expr = (q^sumExponent)*zTerm/denominator;'
        '     (-1)^Total[l]*expr, 0]], {comb, combinations}];'
        ''
        '(*Sum all terms together*)'
        'result = Total[terms];'
        ''
        sprintf('taylorSeries = Series[result, {q, 0, %d}];',Range)
        ''
        '(*Convert the series to normal polynomial form, truncating higher-order terms*)'
        'truncatedResult = Normal[taylorSeries];'
        ''
        'qinf[q_] = '
        '  1 - 2*q - q^2 + 2*q^3 + q^4 + 2*q^5 - 2*q^6 - 2*q^8 - 2*q^9 + q^10;'
        sprintf('series2 = qinf[q]^%d;',Rank)
        'product = truncatedResult*series2;'
        'expandedProduct = Expand[product];'
        sprintf('truncatedResult2 = Normal[Series[expandedProduct, {q, 0, %d}]];',Range)
        'Print[truncatedResult2];'
        'coeffs = CoefficientList[truncatedResult2, q];'
        ''
        'countTerms[expr_] := '
        '  Total[If[Head[#] === Times && IntegerQ[First[FactorTermsList[#]]], '
        '      First[FactorTermsList[#]], If[IntegerQ[#], #, 1]] & /@ '
        '    List @@ expr];'
        'termCounts = countTerms /@ coeffs;'
        ''
        'result = '
        '  Total[coeffs[[1]]] + '
        '   Plus @@ Table['
        '     termCounts[[i]]*q^(i - 1), {i, 2, Length[termCounts]}];'
        ''
        'Print[result];'
    };

    % Open the file for writing
    fid = fopen('script.wl', 'w');
    
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


