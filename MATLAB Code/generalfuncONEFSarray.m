    function result = generalfuncONEFSarray(M, input, range)
        % Define the symbolic variable q
        syms q z
    
        % Determine the number of symbolic l variables (half the length of the input)
        n = length(input) / 2;
        coeffz = 0;
        coeffq = 0;
        % Initialize the result as a symbolic expression
        result = sym(0);
        res = countswaps(M, input);
        qres = replaceSymbols(res, n);
        qres = qres + coeffq;
    
        % Create a grid of points for the summation
        gridPoints = cell(1, n);
        [gridPoints{:}] = ndgrid(0:range);
        
        % Flatten the grid to get all combinations
        combinations = cellfun(@(x) x(:), gridPoints, 'UniformOutput', false);
        combinations = [combinations{:}];
    
        % Perform the summation 
        for i = 1:size(combinations, 1)
            % Substituting each li_sym with its corresponding value
            subsExpr = qres;
            subsExpr2 = coeffz;
            for j = 1:n
                subsExpr = subs(subsExpr, sym(['l', num2str(j), '_sym']), combinations(i, j));
                subsExpr2 = subs(subsExpr2, sym(['l', num2str(j), '_sym']), combinations(i, j));
            end
            sum_exponent = sum(combinations(i, :)) + subsExpr;
            denominator = prod(arrayfun(@(x) qpoch(q, x)^2, combinations(i, :)));
            zexpr = z^(subsExpr2);
            expr = q^sum_exponent*zexpr / denominator;
            result = result + expr;  
        end
    end 
