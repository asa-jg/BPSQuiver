function result = multiply(expr1Func, expr2Func)
    % Get the first expression
    firstExpr = expr1Func();

    % Get the second expression
    secondExpr = expr2Func();
    result1 = firstExpr * secondExpr;

    % Multiply the expressions
    result = expand(result1);

end