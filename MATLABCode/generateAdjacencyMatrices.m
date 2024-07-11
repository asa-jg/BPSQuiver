function matrices = generateAdjacencyMatrices(dimension)
    matrices = [];
    values = [0, 1, -1];
    maxMatrices = 1000000; % Maximum number of matrices to generate

    num_elements = nchoosek(dimension, 2);

    % Initialize the count of valid matrices
    matrixCount = 0;

    % Generate combinations on-the-fly using nested loops
    combs = cell(1, num_elements);
    for i = 1:numel(values)^num_elements
        [combs{:}] = ind2sub(repmat(numel(values), 1, num_elements), i);
        currentComb = values(cell2mat(combs));

        % Create the matrix with antisymmetric property
        M = zeros(dimension);
        comb_idx = 1;
        for row = 1:dimension
            for col = (row + 1):dimension
                M(row, col) = currentComb(comb_idx);
                M(col, row) = -M(row, col);
                comb_idx = comb_idx + 1;
            end
        end
        
        % Check if the matrix has no isolated nodes and is connected
        if ~hasIsolatedNode(M) && isConnected(M) && ~checkCycle(M)
            % Check if this matrix is isomorphic to any already found matrices
            isIsomorphic = false;
            %for k = 1:size(matrices, 3)
            %    if areIsomorphic(M, matrices(:, :, k))
            %        isIsomorphic = true;
            %        break;
            %    end
            %end
            if ~isIsomorphic
                matrices = cat(3, matrices, M);
                matrixCount = matrixCount + 1;
                if matrixCount >= maxMatrices
                    break;
                end
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

function hasCycle = checkCycle(adjacencyMatrix)
    n = size(adjacencyMatrix, 1);
    visited = false(1, n);
    recStack = false(1, n);
    hasCycle = false;
    
    for node = 1:n
        if ~visited(node)
            if dfsCycleCheck(node, visited, recStack, adjacencyMatrix)
                hasCycle = true;
                break;
            end
        end
    end
end

function cycleDetected = dfsCycleCheck(node, visited, recStack, adjacencyMatrix)
    visited(node) = true;
    recStack(node) = true;
    cycleDetected = false;
    
    % Find neighbors where there is an outgoing arrow from the current node
    neighbors = find(adjacencyMatrix(node, :) > 0);
    for i = 1:length(neighbors)
        neighbor = neighbors(i);
        if ~visited(neighbor) && dfsCycleCheck(neighbor, visited, recStack, adjacencyMatrix)
            cycleDetected = true;
            return;
        elseif recStack(neighbor)
            cycleDetected = true;
            return;
        end
    end
    
    recStack(node) = false;
end
