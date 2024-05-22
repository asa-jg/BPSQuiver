function result = countTerms(inputExpr)
    syms z1 z2 z3 z4 z5 z6 z7 z8 z9 z10
    expr = sym(inputExpr);
    symbolicVars = [z1, z2, z3, z4, z5, z6, z7, z8, z9, z10];
    onesVector = ones(size(symbolicVars));
    
    result = subs(expr, symbolicVars, onesVector);
end
