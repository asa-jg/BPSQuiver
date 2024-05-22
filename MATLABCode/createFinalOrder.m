function [FinalOrdering,modifiedVectors, indicesAndCoeffs] = createFinalOrder(M)
    syms k [size(M,1) 1] real;  % symbolic variables k1, k2, ..., kn
    syms l [size(M,1) 1] real;  % symbolic variables l1, l2, ..., ln

    isSuccess = false;
    i = 1;

    while ~isSuccess
        % Process the solution vectors to get modifications for the i-th set
        [modifiedVectors, indicesAndCoeffs, isSuccess] = processSolutionVectors(M, i);
        
        if ~isSuccess
            error('No valid solution found within the range.');
        end

        % Get the graph ordering list
        LST = graphOrderingFS(M);
        disp(LST);
        
        % Initialize the final ordering
        FinalOrdering = [];

        % Iterate through the graph ordering list LST
        for idx = LST
            % Find if idx is one of the indices used in the solution vectors
            if any(indicesAndCoeffs(:,2) == idx)
                % Extract the modified vector for this index
                vecIndex = find(indicesAndCoeffs(:,2) == idx);
                modifiedVector = modifiedVectors(:, vecIndex);
                originalIndex = indicesAndCoeffs(vecIndex, 2); % the b in your example
                
                % Iterate through all non-zero elements in the modified vector
                for j = 1:length(modifiedVector)
                    if modifiedVector(j) ~= 0
                        a = modifiedVector(j); % the coefficient a
                        % Append to FinalOrdering with the expression as specified
                        expression = a * (-k(originalIndex) + l(originalIndex));
                        FinalOrdering = [FinalOrdering; j, expression];
                    end
                end
            else
                % If not an index, use the expression (-ki + li)
                expression = -(k(idx) - l(idx));
                FinalOrdering = [FinalOrdering; idx, expression];
            end
        end

        % Check if any indices used in the solution vectors are in the FinalOrdering
        usedIndices = indicesAndCoeffs(:,2);
        invalidEntries = ismember(FinalOrdering(:,1), usedIndices);
        
        if ~any(invalidEntries)
            isSuccess = true;
        else
            isSuccess = false;
            i = i + 1; % Try the next set of solutions
        end
    end
    
    % Display the FinalOrdering
    disp('Final Ordering:');
    disp(FinalOrdering);
end
