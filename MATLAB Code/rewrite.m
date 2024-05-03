function newExpr = rewrite(inputExpr, maxPower)
    % Define symbolic variables
    syms q z

    % Ensure the expression is in symbolic form
    expr = sym(inputExpr);
    
    % Expand the expression to work with its terms individually
    terms = children(expand(expr));
    
    % Initialize the rewritten expression as an empty symbolic expression
    newExpr = sym(0);
    
    % Loop through each term to rearrange
    for i = 1:length(terms)
        term = terms(i);
        term = sym(term);
        
        % Check if the term includes 'q'
        if has(term, q)
            % Extract the coefficients of q and the corresponding powers
            [coeff, qPowers] = coeffs(term, q);
            
            for j = 1:length(qPowers)
                % Calculate the power of q for the current term
                qPower = feval(symengine, 'degree', qPowers(j));
                
                % Ensure qPower is treated as numerical for comparison
                qPowerNum = double(qPower);
                
                % Include the term if its power is within the specified range
                if qPowerNum <= maxPower
                    newExpr = newExpr + coeff(j) * q^qPowerNum;
                end
            end
        else
            % If the term does not include 'q', add it directly to the new expression
            newExpr = newExpr + term;
        end
    end
    newExpr = collect(newExpr,q);
end
