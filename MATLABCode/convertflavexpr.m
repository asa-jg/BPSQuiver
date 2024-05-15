function resultreal = convertflavexpr(M, indices, modifiedVectors)
    syms k [size(M, 1), 1] real; % Define k as a symbolic vector of size n
    syms l [size(M, 1), 1] real; % Define l as a symbolic vector of size n

    n = size(M, 1);              % Determine the size of the matrix M
    fullList = 1:n;              % Create a list of numbers from 1 to n
    result = cell(length(indices), 1);  % Initialize result as a cell array to hold results for each index

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
