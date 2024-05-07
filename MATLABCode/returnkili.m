function result = returnkili(equation)
    eqn = equation;
    % Extract terms from the equation
    lhside = lhs(eqn);
    rhside = rhs(eqn);
    lhsVars = children(lhside);
    rhsVars = children(rhside);
    
    % Ensure lhsVars is a cell for consistency
    if ~iscell(lhsVars)
        lhsVars = {lhsVars};
    end
    
    % Initialize symbolic variables dynamically based on the input equation
    syms yf
    allVars = [lhsVars, rhsVars];
    for i = 1:length(allVars)
        if ~isa(allVars{i}, 'sym')
            continue; % Skip if not a symbolic variable
        end
        varName = char(allVars{i});
        if varName(1) == 'y' && ~strcmp(varName, 'yf')
            eval(['syms ', varName]);
        end
    end
    
    [coeff, terms] = coeffs(rhside - lhside, yf);
    % Initialize yfCoeff to zero to handle the case where yf is not present
    yfCoeff = sym(0);
    
    % Find the index of yf in the terms and then its corresponding coefficient
    for i = 1:length(terms)
        if terms(i) == yf
            yfCoeff = coeff(i);
            break;
        end
    end
    
    % Check if yfCoeff was found
    if yfCoeff == sym(0)
        error('No yf term found in the equation.');
    end
    
    % Optionally display the coefficient for debugging
    
    % Identify the front y variable in the equation
    frontYVar = lhsVars{1}; % Assuming the front variable is the first in lhsVars
    
    % Construct the result based on the front y variable
    frontYVarName = char(frontYVar);
    i = str2double(frontYVarName(2:end)); % Extract the index i from yi
    
    % Generate the symbolic variables for ki and li
    syms(['k', num2str(i)], ['l', num2str(i)]);
    
    % Calculate the result
    if yfCoeff > 0
        result = ['(', char(sym(['k', num2str(i)]) - sym(['l', num2str(i)])), ')'];
    elseif yfCoeff < 0
        result = ['-(', char(sym(['k', num2str(i)]) - sym(['l', num2str(i)])), ')'];
    else
        error('wee woo');
    end
end
