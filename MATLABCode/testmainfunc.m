function result = testmainfunc()
    syms q;
    result = sym(0);
    q = sym('q');
    z1 = sym('z1');
    z2 = sym('z2');
    z3 = sym('z3');
    z4 = sym('z4');
    z5 = sym('z5');
    gridPoints = cell(1, 10);
    [gridPoints{:}] = ndgrid(0:1);
    combinations = cellfun(@(x) x(:), gridPoints, 'UniformOutput', false);
    combinations = [combinations{:}];
    totalCombinations = size(combinations, 1);
    fprintf('\nProgress: [');
    progressSteps = 1;
    checkPoints = linspace(1, totalCombinations, progressSteps+1);
    parfor i = 1:totalCombinations
        l = combinations(i, :);
        if l(2) + l(3) + l(4) + l(5) == l(7) + l(8) +l(9) + l(10) && l(1) == l(6)
            sum_exponent = 1/2*(sum(l)) + l(6)*l(2) + l(6)*l(3) + l(6)*l(4) + l(6)*l(5);
            z_term = z1^(l(3) - l(8))*z2^(l(9) - l(4))*z3^(l(10) - l(5));
            denominator = prod(arrayfun(@(x) qpoch(q, x), l));
            expr = (q^sum_exponent) * z_term / denominator;
            result = result + expr;
        end
        if any(i == checkPoints)
            fprintf('=');
        end
    end
    fprintf('] % Complete\n');
end
