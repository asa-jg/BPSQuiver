function resultreal = convertflavexpr(M, indices, modifiedVectors)
    syms k [size(M, 1), 1] real; 
    syms l [size(M, 1), 1] real; 

    n = size(M, 1);             
    fullList = 1:n;              
    result = cell(length(indices), 1);  

    % Iterate through each index provided
    for idx = 1:length(indices)
        index = indices(idx);
        remainingList = setdiff(fullList, index);  % Remove the current index from the full list
        totalSum = sym(0); % Initialize symbolic sum for the current index

        % Generate all pairs (i, j) where i > j
        for i = remainingList
            for j = remainingList
                if i > j
                    % Compute the product of M(i, j) and the modified vector entries
                    value = M(i, j) * modifiedVectors(i, idx) * modifiedVectors(j, idx);
                    % Accumulate the value
                    totalSum = totalSum + value;
                end
            end
        end

        % Multiply the accumulated sum by the symbolic expression (-ki + li)^2 / 2
        finalExpr = totalSum * simplify((-k(index) + l(index))^2 / 2);
        
        % Store the final expression for the current index
        result{idx} = finalExpr;
    end

    % Initialize the real result
    resultreal = sym(0);

    % Iterate through each result and multiply by the corresponding z_i
    for idx = 1:length(result)
        resultreal = resultreal + result{idx};
    end
end
