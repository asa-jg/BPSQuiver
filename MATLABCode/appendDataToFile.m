function appendDataToFile(matrixData, intData, symExpr)
    fid = fopen('SchurIndexList.txt', 'a');
    syms q
    if fid == -1
        error('Failed to open the file.');
    end

    fprintf(fid, 'BPS quiver ajacency matrix:\n');
    for i = 1:size(matrixData, 1)
        fprintf(fid, '%g\t', matrixData(i, :));
        fprintf(fid, '\n');
    end

    fprintf(fid, 'Rank of the Coulomb branch:\n%d\n', intData);

    fprintf(fid, 'Schur index:\n');
    string = getPaddedCoefficients(symExpr);
    string = mat2str(string);
    fprintf(fid, '%s\n', string);
    fprintf(fid, '%s\n', char(symExpr));
    fprintf(fid, '\n');

    fclose(fid);
end