function expr = generateZexpr(indices)
    % Validate input indices
    if isempty(indices)
        error('No indices provided.');
    end
    
    % Define symbolic variables
    syms z [1 length(indices)] real;  % z_1 to z_n where n is the number of indices
    k = sym('k', [1 max(indices)], 'real');  % Create k variables up to the maximum index
    l = sym('l', [1 max(indices)], 'real');  % Create l variables up to the maximum index
    
    expr = 1;  % Initialize the expression
    
    % Construct the expression by iterating over indices
    for i = 1:length(indices)
        idx = indices(i);  % Current index for k and l
        % Construct the term for the current index using sequential z_i
        term = z(i) ^ (-k(idx) + l(idx));
        
        % Multiply the current term with the accumulating expression
        expr = expr * term;
    end
end
