function [qresult,zresult] = superloop(M)
    list = graphOrdering(M);
    swaps = countswaps(M,list);
    [modifiedVectors, indicesAndCoeffs] = processSolutionVectors(M);
    columnVector = indicesAndCoeffs(:,2);
    indices = columnVector.'; 
    %disp(modifiedVectors);
    results = convertflavexpr(M, indices, modifiedVectors);
    %disp(swaps);
    %disp(mainloop(M));
    %disp(results);

    qresult = (swaps) + (mainloop(M)) + (results);
    zresult =  generateZexpr(indices);
    