function result = testmainfunc()
    % Define symbolic variables
    q = sym('q');
    z1 = sym('z1');
    z2 = sym('z2');
    z3 = sym('z3');
    z4 = sym('z4');
    z5 = sym('z5');
    result = sym(0);

    % Define the range for grid points and the number of dimensions
    gridRange = 0:3;
    numDimensions = 14;
    totalCombinations = numel(gridRange)^numDimensions;

    % Display progress
    fprintf('\nProgress: [');
    progressSteps = 3;
    checkPoints = linspace(1, totalCombinations, progressSteps + 1);

    % Parallel processing loop
    parfor i = 1:totalCombinations
        % Generate the combination for the current index
        l = combinationFromIndex(i, gridRange, numDimensions);

        % Apply the given conditions
        if l(7) + l(1) == l(14) + l(8) && l(5) + l(8) == l(12) + l(1) && ...
           l(6) == l(13) && l(3) + l(1) == l(10) + l(8) && l(4) == l(11) && l(2) == l(9)

            % Calculate sum_exponent, z_term, and denominator
            sum_exponent = 1/2 * sum(l) + l(9) * l(1) + l(9) * l(3) + ...
                           l(11) * l(3) + l(11) * l(5) + l(13) * l(5) + l(13) * l(7);
            z_term = z1^(l(1) - l(8));
            denominator = prod(arrayfun(@(x) qpoch(q, x), l));
            expr = (q^sum_exponent) * z_term / denominator;
            
            % Update the result
            result = result + (-1)^sum(l) * expr;
        end

        % Display progress
        if any(i == round(checkPoints))
            fprintf('=');
        end
    end

    fprintf('] % Complete\n');
end

function combination = combinationFromIndex(index, range, dimensions)
    % Generate a combination from the given index
    numElements = numel(range);
    combination = zeros(1, dimensions);

    for d = 1:dimensions
        currentIndex = mod(index - 1, numElements) + 1;
        combination(d) = range(currentIndex);
        index = (index - currentIndex) / numElements + 1;
    end
end
