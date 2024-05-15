function [modifiedVectors, indicesAndCoeffs, isSuccess] = processSolutionVectors(M)
    % Compute the null space of the matrix M
    Y_raw = null(M, 'rational');
    
    % Check if there are any solutions
    if isempty(Y_raw)
        disp('No independent solutions exist.');
        modifiedVectors = [];
        indicesAndCoeffs = [];
        isSuccess = false;  % Return false indicating failure to process
        return;  % Exit the function early
    end

    numSolutions = size(Y_raw, 2);
    n = size(Y_raw, 1);
    
    % To keep track of which indices have been normalized
    usedIndices = false(n, 1);
    
    % Prepare output variables
    modifiedVectors = zeros(size(Y_raw));
    indicesAndCoeffs = zeros(numSolutions, 2); % First column for coeffs, second for indices

    % Process each solution vector
    for k = 1:numSolutions
        vector = Y_raw(:, k);
        
        % Find the first non-zero, not-yet-used coefficient to normalize
        for idx = 1:n
            if vector(idx) ~= 0 && ~usedIndices(idx)
                % Mark the index as used
                usedIndices(idx) = true;
                
                % Normalize the vector by this coefficient
                coeff = -vector(idx);
                vector = vector / coeff;
                
                % Set the normalized index to zero
                vector(idx) = 0;
                
                % Store the modified vector and the index/coefficient used
                modifiedVectors(:, k) = vector;
                indicesAndCoeffs(k, :) = [coeff, idx];
                
                break;
            end
        end
    end
    
    %disp('z term and gammas (coeffs and indices):');
    %disp(indicesAndCoeffs);
    
    isSuccess = true;  % Return true indicating successful processing
end
