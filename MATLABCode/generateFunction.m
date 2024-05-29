function generateFunction(adjMatrix, inputList, rangeVal)
    % Compute swaps
    swaps = countswaps(adjMatrix, inputList);

    % Apply the change function to swaps
    swapsnew = change(swaps);

    % Open a new file to write the function
    fid = fopen('hardcoded_generalfunc.m', 'w');

    % Write the function definition
    fprintf(fid, 'function result = hardcoded_generalfunc(Range)\n');
    fprintf(fid, '    syms q;\n'); % Define q at the top level for visibility
    fprintf(fid, '    result = sym(0);\n');
    fprintf(fid, '    q = sym(''q'');\n'); % Redefine q inside the function for clarity

    % Write the code to create gridPoints and combinations
    fprintf(fid, '    gridPoints = cell(1, %d);\n', length(inputList)/2);
    fprintf(fid, '    [gridPoints{:}] = ndgrid(0:%d);\n', rangeVal);
    fprintf(fid, '    combinations = cellfun(@(x) x(:), gridPoints, ''UniformOutput'', false);\n');
    fprintf(fid, '    combinations = [combinations{:}];\n');
    fprintf(fid, '    totalCombinations = size(combinations, 1);\n');

    % Initialize progress bar
    fprintf(fid, '    fprintf(''\\nProgress: ['');\n');
    fprintf(fid, '    progressSteps = %d;\n', rangeVal); % Number of progress steps
    fprintf(fid, '    checkPoints = linspace(1, totalCombinations, progressSteps+1);\n'); % Determine checkpoints

    % Write the parfor loop for summation with progress updates
    fprintf(fid, '    parfor i = 1:totalCombinations\n');
    fprintf(fid, '            l = combinations(i, :);\n');
    fprintf(fid, '        if sum(l) < %d ;\n', 2*rangeVal + 2);
    fprintf(fid, '            sum_exponent = sum(l) + %s;\n', swapsnew);
    fprintf(fid, '            denominator = prod(arrayfun(@(x) qpoch(q, x)^2, l));\n');
    fprintf(fid, '            expr = q^sum_exponent / denominator;\n');
    fprintf(fid, '            result = result + expr;\n');
    % Insert progress update simulation
    fprintf(fid, '            if any(i == checkPoints)\n');
    fprintf(fid, '                fprintf(''='');\n');
    fprintf(fid, '            end\n');
    fprintf(fid, '        end\n');

    fprintf(fid, '    end\n');
    fprintf(fid, '    fprintf(''] %% Complete\\n'');\n'); % Close progress bar

    % Close the file
    fclose(fid);
end
