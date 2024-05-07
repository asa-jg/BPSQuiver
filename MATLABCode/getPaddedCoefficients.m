function paddedCoefficients = getPaddedCoefficients(polynomial)
    % Define the maximum degree for padding
    maxDegree = 20;

    % Ensure the polynomial is a symbolic expression
    if ~isa(polynomial, 'sym')
        polynomial = sym(polynomial);
    end

    % Get the coefficients and the degree of the polynomial
    coefficients = coeffs(polynomial, 'All');
    polyDegree = feval(symengine, 'degree', polynomial);

    % Initialize an array of zeros of length maxDegree
    paddedCoefficients = zeros(1, maxDegree);

    % Place the coefficients in the array
    startIndex = maxDegree - polyDegree;
    paddedCoefficients(startIndex + 1 : startIndex + length(coefficients)) = double(coefficients);

    % Flip the array for ascending order
    paddedCoefficients = fliplr(paddedCoefficients);
end
