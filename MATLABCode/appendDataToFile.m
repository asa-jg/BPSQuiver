function appendDataToFile(matrixData, symExpr1, symExpr2)
    fid = fopen('SchurIndexList4Nodes.txt', 'a');
    if fid == -1
        error('Failed to open the file.');
    end
    matrixData(matrixData < 0) = 0;
    matrixData(matrixData == -0) = 0;




    fprintf(fid, 'BPS quiver ajacency matrix:\n');
    for i = 1:size(matrixData, 1)
        fprintf(fid, '%g\t', matrixData(i, :));
        fprintf(fid, '\n');
    end
    fprintf(fid, '\n');

    fprintf(fid, 'Refined Schur index:\n');
    fprintf(fid, '%s\n', symExpr1);
    fprintf(fid, '\n');
    fprintf(fid, 'Unrefined Schur index:\n');
    fprintf(fid, '%s\n', symExpr2);
    fprintf(fid, '\n');
end
