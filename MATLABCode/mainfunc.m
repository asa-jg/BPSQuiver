function result = mainfunc()
    syms q;
    result = sym(0);
    q = sym('q');
    z1 = sym('z1');
    z2 = sym('z2');
    z3 = sym('z3');
    z4 = sym('z4');
    z5 = sym('z5');
    gridPoints = cell(1, 8);
    [gridPoints{:}] = ndgrid(0:4);
    combinations = cellfun(@(x) x(:), gridPoints, 'UniformOutput', false);
    combinations = [combinations{:}];
    totalCombinations = size(combinations, 1);
    fprintf('\nProgress: [');
    progressSteps = 4;
    checkPoints = linspace(1, totalCombinations, progressSteps+1);
    parfor i = 1:totalCombinations
        l = combinations(i, :);
        if l(2) + l(1) == l(6) + l(5) && l(4) + l(3) == l(8) + l(7) && sum(l) < 2*4 +2
            sum_exponent = 1/2*(sum(l)) + l(7)*l(1) + l(7)*l(2) + l(8)*l(1) + l(8)*l(2);
            z_term = z1^(l(2) - l(6))*z2^(l(4) - l(8));
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
