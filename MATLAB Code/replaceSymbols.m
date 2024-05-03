function result = replaceSymbols(expr, numVariables)
    % replaceSymbols replaces k_i and l_i with l_i_sym in the symbolic expression
    %
    % Inputs:
    % expr - the symbolic expression output from arrangeListAndCountSwaps
    % numVariables - the number of l_i and q_i variables in the expression

    % Initialize the result as the input expression
    result = expr;

    % Perform substitutions for q_i and l_i
    for i = 1:numVariables
        qSym = sym(['k', num2str(i)]);
        lSym = sym(['l', num2str(i)]);
        lSymNew = sym(['l', num2str(i), '_sym']);

        % Replace q_i and l_i with l_i_sym
        result = subs(result, [qSym, lSym], [lSymNew, lSymNew]);
    end
end
