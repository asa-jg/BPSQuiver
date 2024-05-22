function [modifiedVectors, indicesAndCoeffs, isSuccess] = processSolutionVectors(M, i)
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
    
    % Prepare to collect all combinations
    allModifiedVectors = {};
    allIndicesAndCoeffs = {};
    
    % Generate all possible combinations of indices
    allIndexCombos = combnk(1:n, numSolutions);
    
    % Iterate through all combinations of indices
    for comboIdx = 1:size(allIndexCombos, 1)
        usedIndices = allIndexCombos(comboIdx, :);
        
        % Prepare storage for this combination
        currentModifiedVectors = zeros(size(Y_raw));
        currentIndicesAndCoeffs = zeros(numSolutions, 2); % First column for coeffs, second for indices
        
        isValidCombo = true;
        
        % Process each solution vector
        for k = 1:numSolutions
            vector = Y_raw(:, k);
            
            % Get the current index to use for normalization
            idx = usedIndices(k);
            
            if vector(idx) == 0
                isValidCombo = false;
                break;
            end
            
            % Normalize the vector by this coefficient
            coeff = -vector(idx);
            vector = vector / coeff;
            
            % Set the normalized index to zero
            vector(idx) = 0;
            
            % Store the modified vector and the index/coefficient used
            currentModifiedVectors(:, k) = vector;
            currentIndicesAndCoeffs(k, :) = [coeff, idx];
        end
        
        if isValidCombo
            allModifiedVectors{end+1} = currentModifiedVectors;
            allIndicesAndCoeffs{end+1} = currentIndicesAndCoeffs;
        end
    end
    
    % Check if the requested index is within the range of possible combinations
    if i > length(allModifiedVectors) || i < 1
        modifiedVectors = [];
        indicesAndCoeffs = [];
        isSuccess = false;  % Return false indicating failure to process
        return;  % Exit the function early
    end
    
    % Return the ith combination
    modifiedVectors = allModifiedVectors{i};
    indicesAndCoeffs = allIndicesAndCoeffs{i};
    isSuccess = true;  % Return true indicating successful processing
end
