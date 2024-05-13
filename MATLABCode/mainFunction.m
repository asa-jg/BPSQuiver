function FinalOrdering = mainFunction(M)
    syms k [size(M,1) 1] real;  % symbolic variables k1, k2, ..., kn
    syms l [size(M,1) 1] real;  % symbolic variables l1, l2, ..., ln

    % Process the solution vectors to get modifications
    [modifiedVectors, indicesAndCoeffs] = processSolutionVectors(M);
    
    % Get the graph ordering list
    LST = graphOrderingFS(M);
    
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
            for i = 1:length(modifiedVector)
                if modifiedVector(i) ~= 0
                    a = modifiedVector(i); % the coefficient a
                    % Append to FinalOrdering with the expression as specified
                    expression = a * (k(originalIndex) - l(originalIndex));
                    FinalOrdering = [FinalOrdering; i, expression];
                end
            end
        else
            % If not an index, use the expression (-ki + li)
            expression = -(k(idx) - l(idx));
            FinalOrdering = [FinalOrdering; idx, expression];
        end
    end
    
    % Display the FinalOrdering
    disp('Final Ordering:');
    disp(FinalOrdering)
    end

