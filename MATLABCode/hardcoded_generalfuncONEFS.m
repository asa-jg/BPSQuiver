function result = hardcoded_generalfuncONEFS(Range)
    result = sym(0);
    q = sym('q'); % Ensuring q is defined as symbolic within the function
    z = sym('z'); % Ensuring q is defined as symbolic within the function
    
    gridPoints = cell(1, 6);
    [gridPoints{:}] = ndgrid(0:1); 
    
    combinations = cellfun(@(x) x(:), gridPoints, 'UniformOutput', false);
    combinations = [combinations{:}];
    totalCombinations = size(combinations, 1);
    
    fprintf('\nProgress: [');
    progressSteps = Range; % Adjusted to match the Range for progress reporting
    checkPoints = linspace(1, totalCombinations, progressSteps+1);
    
    parfor i = 1:totalCombinations
        l = combinations(i, :);
        if l(4) + l(6) == l(1) + l(3) && l(5) + l(6) == l(2) + l(3)
            expr = ((-1)^(sum(l))*q^((1/2)*(sum(l))+ -(l(6) - l(3))^2/2 + l(5)*l(1) + l(6)*l(1) - l(6)*l(2))*z^(2*-(l(6) - l(3))))/(qpoch(q,l(1))*(qpoch(q,l(2)))*(qpoch(q,l(3)))*(qpoch(q,l(4)))*(qpoch(q,l(5)))*(qpoch(q,l(6))));
            result = result + expr;
        end
        if any(i == checkPoints)
            fprintf('=');
        end
    end
    fprintf(']\n');
    disp(result);