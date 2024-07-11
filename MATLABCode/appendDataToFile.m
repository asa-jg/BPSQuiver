function appendDataToFile(matrixData, symExpr1)
    fid = fopen('SchurIndexList5Nodes.txt', 'a');
    if fid == -1
        error('Failed to open the file.');
    end
    matrixData(matrixData < 0) = 0;
    matrixData(matrixData == -0) = 0;




    fprintf(fid, 'BPS quiver adjacency matrix:\n');
    for i = 1:size(matrixData, 1)
        fprintf(fid, '%g\t', matrixData(i, :));
        fprintf(fid, '\n');
    end
    fprintf(fid, '\n');

    fprintf(fid, 'Schur index:\n');
    fprintf(fid, '%s\n', symExpr1);
    fprintf(fid, '\n');
end
