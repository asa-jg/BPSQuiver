function [qresult,zresult, newkron] = superloop(M)
    list = graphOrdering(M);
    swaps = countswaps(M,list);
    [~,modifiedVectors, indicesAndCoeffs] = createFinalOrder(M);
    columnVector = indicesAndCoeffs(:,2);
    indices = columnVector.'; 
    %disp(modifiedVectors);
    %disp(indicesAndCoeffs)
    results = convertflavexpr(M, indices, modifiedVectors);
    %disp(swaps);
    %disp(mainloop(M));
    %disp(results);
    [counter, newkron] = (mainloop(M));

    qresult = (swaps) + counter + (results);
    zresult =  generateZexpr(indices);
    