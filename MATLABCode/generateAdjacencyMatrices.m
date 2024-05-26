function matrices = generateAdjacencyMatrices(dimension)
    matrices = [];
    values = [0, 1];
    num_values = length(values);

    % Number of elements in the upper triangle (excluding diagonal)
    num_elements = nchoosek(dimension, 2);

    % Generate all possible combinations for these elements
    combs = cell(1, num_elements);
    [combs{:}] = ndgrid(values);
    combs = cell2mat(cellfun(@(x) x(:), combs, 'UniformOutput', false));
    num_combinations = size(combs, 1);

    % Iterate over all combinations
    for i = 1:num_combinations
        % Create the matrix with antisymmetric property
        M = zeros(dimension);
        comb_idx = 1;
        for row = 1:dimension
            for col = (row + 1):dimension
                M(row, col) = combs(i, comb_idx);
                M(col, row) = -M(row, col);
                comb_idx = comb_idx + 1;
            end
        end
        
        % Check if the matrix has no isolated nodes and is connected
        if ~hasIsolatedNode(M) && isConnected(M)
            % Check if this matrix is isomorphic to any already found matrices
            isIsomorphic = false;
            for k = 1:size(matrices, 3)
                if areIsomorphic(M, matrices(:, :, k))
                    isIsomorphic = true;
                    break;
                end
            end
            if ~isIsomorphic
                matrices = cat(3, matrices, M);
            end
        end
    end
end

function result = hasIsolatedNode(M)
    % Check if there is any isolated node (entire row being zero)
    result = any(all(M == 0, 2));
end

function result = isConnected(M)
    % Check if the graph represented by adjacency matrix M is connected
    G = graph(abs(M)); % Use absolute values to ignore directions
    result = all(conncomp(G) == 1); % All nodes must belong to the same component
end


