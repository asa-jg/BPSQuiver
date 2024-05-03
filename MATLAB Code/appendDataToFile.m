function appendDataToFile(matrixData, intData, symExpr)
    % Open the file in append mode
    fid = fopen('SchurIndexList.txt', 'a');
    syms q
    % Check if the file was opened successfully
    if fid == -1
        error('Failed to open the file.');
    end

    % Print a matrix
    fprintf(fid, 'BPS quiver ajacency matrix:\n');
    for i = 1:size(matrixData, 1)
        fprintf(fid, '%g\t', matrixData(i, :));
        fprintf(fid, '\n');
    end

    % Print a list
    %fprintf(fid, 'Ordering of the central charges:\n');
    %fprintf(fid, '%g\t', listData);
    %fprintf(fid, '\n');

    % Print an integer
    fprintf(fid, 'Rank of the Coulomb branch:\n%d\n', intData);

    % Print a symbolic expression
    fprintf(fid, 'Schur index:\n');
    string = getPaddedCoefficients(symExpr);
    string = mat2str(string);
    fprintf(fid, '%s\n', string);
    fprintf(fid, '%s\n', char(symExpr));
    fprintf(fid, '\n');

    % Close the file
    fclose(fid);
end