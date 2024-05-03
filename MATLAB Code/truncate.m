function truncatedPoly = truncate(inputPoly, m)
    % Convert the input symbolic polynomial to a vector of coefficients
    coeffVector = coeffs(inputPoly, 'All');
    % Reverse the order of the coefficients
    reversedCoeffVector = fliplr(coeffVector);
    % Truncate the list up to the degree m
    if length(reversedCoeffVector) > m
        truncatedCoeffVector = reversedCoeffVector(1:m);
    else
        truncatedCoeffVector = reversedCoeffVector;
    end
    % Reverse the truncated list
    finalCoeffVector = fliplr(truncatedCoeffVector);
    % Convert the vector of coefficients back to a symbolic polynomial
    syms q;
    truncatedPoly = poly2sym(finalCoeffVector, q);
end