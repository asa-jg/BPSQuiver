function expressions = returnkrondet(equation)
    % Validate input
    if ~isa(equation, 'sym')
        error('Input must be a symbolic equation.');
    end
    
    % Convert the equation to a string
    eqStr = string(equation);
    
    % Split the equation into LHS and RHS
    parts = split(eqStr, "==");
    lhsStr = char(parts(1));
    rhsStr = char(parts(2));
    rhsStr = regexprep(rhsStr, 'yf', '');
    % Find variables in the equation
    vars = symvar(equation);
    
    % Initialize pairs matrix
    pairs = [];
    
    % Initialize variable to store the LHS 'i' value
    lhsPair = [];
    for i = 1:length(vars)
        varName = char(vars(i));
            
        if contains(lhsStr, varName)
            % Extract and store the 'i' value for LHS variable
            lhsPair = [lhsPair, str2double(regexp(varName, '\d+', 'match'))];
        end
    end
    for var = vars(~contains(string(vars), lhsStr))
        varName = char(var);
        if contains(rhsStr, varName)
            % Extract 'i' value
            rhsPair = str2double(regexp(varName, '\d+', 'match'));
            pairs = [pairs; [lhsPair, rhsPair]];
        end
    end
% Transform pairs into symbolic expressions
    expressions = []; % Initialize expressions array
    for i = 1:size(pairs)
        n = pairs(i, 1);
        m = pairs(i, 2);
        
        % Dynamically generate variable names
        kn = sym(['k', num2str(n)]);
        km = sym(['k', num2str(m)]);
        ln = sym(['l', num2str(n)]);
        lm = sym(['l', num2str(m)]);
        
        % Combine into expressions
        expression = [kn + km, ln + lm];
        
        % Append to expressions array
        expressions = [expressions; expression];
    end
end