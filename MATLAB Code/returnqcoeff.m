function result = returnqcoeff(equation)
    eqStr = string(equation);
    eqStr = regexprep(eqStr, '+ yf', '');
    eqStr = regexprep(eqStr, '- yf', '');

    eqStr = str2sym(eqStr);
    result = eqStr;