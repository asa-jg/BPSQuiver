function outputExprs = rearrangefearrayONEFS(inputExpr)
    syms yf; % Assuming yf is always present in the expression
    vars = symvar(inputExpr); % Extract variables from the expression
    vars = vars(vars ~= yf); % Remove 'yf' from the list of variables
    
    % Initialize a cell array to hold all possible rearranged expressions
    exprsCell = cell(1, length(vars));
    
    for i = 1:length(vars)
        LHS = vars(i);
        RHS = solve(inputExpr, vars(i)); % Solve the input expression for each variable
        simplifiedExpr = LHS == RHS; % Create the rearranged expression
        
        % Store the simplified expression in the cell array
        exprsCell{i} = simplifiedExpr;
    end
    
    % Convert the cell array to a symbolic array if needed, or return as is
    % Depending on how you want to use the output, you can either leave it as a cell array
    % or convert it to a symbolic array if they are of the same size.
    % Here, we return the cell array directly
    outputExprs = exprsCell;
end
