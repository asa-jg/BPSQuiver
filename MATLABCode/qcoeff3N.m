function expr = qcoeff3N(numbers, M)
    % Ensure numbers is a row vector
    numbers = numbers(:)';
    
    % Sort the numbers in descending order
    numbers = sort(numbers, 'descend');
    
    % Get the number of elements in the list
    n = numel(numbers);
    
    % Calculate the total number of combinations n choose 2
    numPairs = nchoosek(n, 2);
    
    % Initialize the output matrix for pairs
    pairs = zeros(numPairs, 2);
    
    % Initialize the symbolic sum variable
    symSum = sym(0);
    
    % Index to track the position in the output matrices
    idx = 1;
    
    % Loop through each unique pair of indices
    for i = 1:n-1
        for j = i+1:n
            % Assign pairs in descending order
            pairs(idx, :) = [numbers(i), numbers(j)];
            % Add the sum of the corresponding matrix elements
            symSum = symSum + M(numbers(i), numbers(j));
            idx = idx + 1;
        end
    end
    disp(symSum)
    % Define symbolic variables for n
    syms n_sym real
    
    % Create the final symbolic expression
    expr = simplify(symSum * (n_sym/2) + n_sym*(n_sym-1)/2)
    
    % Substitute the actual number of elements into the symbolic expression
    expr = subs(expr, n_sym, n)
end