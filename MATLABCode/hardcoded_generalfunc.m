function result = hardcoded_generalfunc(Range)
    syms q;
    result = sym(0);
    q = sym('q');
    gridPoints = cell(1, 4);
    [gridPoints{:}] = ndgrid(0:8);
    combinations = cellfun(@(x) x(:), gridPoints, 'UniformOutput', false);
    combinations = [combinations{:}];
    totalCombinations = size(combinations, 1);
    fprintf('\nProgress: [');
    progressSteps = 8;
    checkPoints = linspace(1, totalCombinations, progressSteps+1);
    parfor i = 1:totalCombinations
            l = combinations(i, :);
        if sum(l) < 18 ;
            sum_exponent = sum(l) + 2*l(1)*l(2) + 2*l(3)*l(1) + 2*l(3)*l(2) + 2*l(4)*l(2) + 2*l(4)*l(3);
            denominator = prod(arrayfun(@(x) qpoch(q, x)^2, l));
            expr = q^sum_exponent / denominator;
            result = result + expr;
            if any(i == checkPoints)
                fprintf('=');
            end
        end
    end
    fprintf('] % Complete\n');
