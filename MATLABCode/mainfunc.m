function result = mainfunc()
    syms q;
    result = sym(0);
    q = sym('q');
    z1 = sym('z1');
    z2 = sym('z2');
    z3 = sym('z3');
    z4 = sym('z4');
    z5 = sym('z5');
    gridPoints = cell(1, 6);
    [gridPoints{:}] = ndgrid(0:7);
    combinations = cellfun(@(x) x(:), gridPoints, 'UniformOutput', false);
    combinations = [combinations{:}];
    totalCombinations = size(combinations, 1);
    fprintf('\nProgress: [');
    progressSteps = 7;
    checkPoints = linspace(1, totalCombinations, progressSteps+1);
    parfor i = 1:totalCombinations
        l = combinations(i, :);
        if l(1) + l(3) == l(4) + l(6) && l(4) + l(2) == l(1) + l(5)
            sum_exponent = 1/2*(sum(l)) + l(5)*l(1) + l(6)*l(1) + l(5)*l(3) + (l(4) - l(1))*(l(6) - l(3)) + (l(4) - l(1))^2/2;
            z_term = z1^(l(1) - l(4));
            denominator = prod(arrayfun(@(x) qpoch(q, x), l));
            expr = (q^sum_exponent) * z_term / denominator;
            result = result + (-1)^(sum(l)) * expr;
        end
        if any(i == checkPoints)
            fprintf('=');
        end
    end
    fprintf('] Calculating Taylor series...');
end
