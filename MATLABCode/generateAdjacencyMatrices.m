function matrices = generateAdjacencyMatrices(dimension, random, maxMatrices)
    matrices = [];
    values = [0, 1, -1];

    num_elements = nchoosek(dimension, 2);
    num_combinations = numel(values)^num_elements;

    progressFile = 'matrices_progress.mat'; 

    matrixCount = 0;

    indices = 1:num_combinations;

    if random
        indices = randperm(num_combinations);
    end

    generatedIndices = false(1, num_combinations);

    try
        for idx = indices
            if random && generatedIndices(idx)
                continue;
            end

            if random
                generatedIndices(idx) = true;
            end

            combs = cell(1, num_elements);
            [combs{:}] = ind2sub(repmat(numel(values), 1, num_elements), idx);
            currentComb = values(cell2mat(combs));

            M = zeros(dimension);
            comb_idx = 1;
            for row = 1:dimension
                for col = (row + 1):dimension
                    M(row, col) = currentComb(comb_idx);
                    M(col, row) = -M(row, col);
                    comb_idx = comb_idx + 1;
                end
            end

            if ~hasIsolatedNode(M) && isConnected(M) && ~checkCycle(M)
                isIsomorphic = false;
                for k = 1:size(matrices, 3)
                    if areIsomorphic(M, matrices(:, :, k))
                        isIsomorphic = true;
                        break;
                    end
                end
                if ~isIsomorphic
                    matrices = cat(3, matrices, M);
                    matrixCount = matrixCount + 1;
                    disp(matrixCount);
                    if mod(matrixCount, 10) == 0
                        saveProgress(matrices);
                    end
                    if matrixCount >= maxMatrices
                        break;
                    end
                end
            end
        end
    catch ME
        disp(['Error occurred: ', ME.message]);
        saveProgress(matrices);
    end
end

function saveProgress(matrices)
    save('matrices_progress.mat', 'matrices');
end

function result = hasIsolatedNode(M)
    result = any(all(M == 0, 2));
end

function result = isConnected(M)
    G = graph(abs(M)); 
    result = all(conncomp(G) == 1); 
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
