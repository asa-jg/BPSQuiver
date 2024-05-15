function sumResult = sumqcoeff(M, modifiedVectors, indicesAndCoeffs)
    % M is the input matrix
    % modifiedVectors are the modified vectors from processSolutionVectors
    % indicesAndCoeffs contain the indices and their corresponding coefficients
    
    % Extract indices from indicesAndCoeffs
    indices = indicesAndCoeffs(:, 2);
    
    % Extract coefficients from indicesAndCoeffs
    coefficients = modifiedVectors;
    
    % Get the size of the matrix
    n = size(M, 1);
    
    % Create a list from 1 to n
    fullList = 1:n;
    
    % Remove the indices from the list
    remainingIndices = setdiff(fullList, indices);
    
    % Initialize sumResult
    sumResult = 0;
    
    % Calculate the sum of M(i, j)*a*b where i > j, for i, j in the remaining list
    for iIndex = 1:length(remainingIndices)
        for jIndex = 1:iIndex-1  % Ensure that i > j
            i = remainingIndices(iIndex);
            j = remainingIndices(jIndex);
            a = coefficients(iIndex);
            b = coefficients(jIndex);
            sumResult = sumResult + M(i, j) * a * b;
        end
    end
end
