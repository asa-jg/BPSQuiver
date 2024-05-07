function result = hardcoded_generalfunc(Range)
    syms q;
    result = sym(0);
    q = sym('q');
    gridPoints = cell(1, 2);
    [gridPoints{:}] = ndgrid(0:10);
    combinations = cellfun(@(x) x(:), gridPoints, 'UniformOutput', false);
    combinations = [combinations{:}];
    totalCombinations = size(combinations, 1);
    fprintf('\nProgress: [');
    progressSteps = 10;
    checkPoints = linspace(1, totalCombinations, progressSteps+1);
    parfor i = 1:totalCombinations
        l = combinations(i, :);
        sum_exponent = sum(l) + 2*l(2)*l(1);
        denominator = prod(arrayfun(@(x) qpoch(q, x)^2, l));
        expr = q^sum_exponent / denominator;
        result = result + expr;
        if any(i == checkPoints)
            fprintf('=');
        end
    end
    fprintf('] % Complete\n');
