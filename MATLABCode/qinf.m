function series = qinf(q)
    % Define symbolic variable x
    syms q;

    % Define the coefficients
    coefficients = [1, -2, -1, 2, 1, 2, -2, 0, -2, -2, 1, 0, 0, 2, 3, -2, 2, 0, 0, -2, -2, 0, 0, -2, -1, 0, 2, 2, -2, 2, 1, 2, 0, 2, -2, -2, 2, 0, -2, 0, -4, 0, 0, 0, 1, -2, 0, 0, 2, 0, 2, 2, 1, -2, 0, 2, 2, 0, 0, -2, 0, -2, 0, -2, 2, 0, -4, 0, 0, -2, -1, 2, 0, 2, 0, 0, 0, -2];

    % Initialize the series
    series = sym(0);
    
    % Construct the series
    for i = 1:length(coefficients)
        series = series + coefficients(i) * q^(i-1);
    end
    
end