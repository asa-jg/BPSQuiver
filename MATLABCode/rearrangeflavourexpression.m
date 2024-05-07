function outputExpr = rearrangeflavourexpression(inputExpr)
    syms yf; % Assuming yf is always present in the expression
    vars = symvar(inputExpr); % Extract variables from the expression
    vars(vars == yf) = []; % Remove 'yf' from the list of variables
    
    % Initialize for comparison and tracking
    minMinusCount = inf; % For tracking the minimum number of minus signs
    bestExpr = sym(0); % To hold the best expression with the fewest minus signs
    
    for i = 1:length(vars)
        LHS = vars(i);
        RHS = solve(inputExpr, vars(i));
        simplifiedExpr = LHS == RHS;
        minusCount = numel(strfind(char(simplifiedExpr), '-'));
        
        % Update if this expression has fewer minus signs
        if minusCount < minMinusCount
            minMinusCount = minusCount;
            bestExpr = simplifiedExpr;
        end
    end
    
    outputExpr = bestExpr;
end