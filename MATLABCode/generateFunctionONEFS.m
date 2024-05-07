function generateFunctionONEFS(adjMatrix, inputList, rangeVal, coeffq, coeffz, modifiedArray,normalise_z)
    % Compute swaps or any necessary computation for ONEFS
    swaps = countswaps(adjMatrix, inputList); % Assuming similar preprocessing
    syms l1 k1
    sizes = size(adjMatrix);
    n = sizes(1);
    swapsnew = changeflavour(swaps, n);
    coeffznew = changeflavour(coeffz, n);
    coeffqnew = changeflavour(coeffq, n);
    condition = generatekd(modifiedArray);
    % Open a new file to write the function for ONEFS
    fid = fopen('hardcoded_generalfuncONEFS.m', 'w');
    
    % Write the function definition exactly as hardcoded_generalfunc_sixdim
    fprintf(fid, 'function result = hardcoded_generalfuncONEFS(Range)\n');
    fprintf(fid, '    result = sym(0);\n');
    fprintf(fid, '    q = sym(''q''); %% Ensuring q is defined as symbolic within the function\n');
    fprintf(fid, '    z = sym(''z''); %% Ensuring q is defined as symbolic within the function\n');

    fprintf(fid, '    \n');
    fprintf(fid, '    gridPoints = cell(1, 6);\n');
    fprintf(fid, '    [gridPoints{:}] = ndgrid(0:%d); \n',rangeVal);
    fprintf(fid, '    \n');
    fprintf(fid, '    combinations = cellfun(@(x) x(:), gridPoints, ''UniformOutput'', false);\n');
    fprintf(fid, '    combinations = [combinations{:}];\n');
    fprintf(fid, '    totalCombinations = size(combinations, 1);\n');
    fprintf(fid, '    \n');
    fprintf(fid, '    fprintf(''\\nProgress: ['');\n');
    fprintf(fid, '    progressSteps = Range; %% Adjusted to match the Range for progress reporting\n');
    fprintf(fid, '    checkPoints = linspace(1, totalCombinations, progressSteps+1);\n');
    fprintf(fid, '    \n');
    fprintf(fid, '    parfor i = 1:totalCombinations\n');
    fprintf(fid, '        l = combinations(i, :);\n');
    fprintf(fid, '        %s\n', condition);
    fprintf(fid, '            expr = ((-1)^(sum(l))*q^((1/2)*(sum(l))+ %s + %s)*z^(2*%s))/(qpoch(q,l(1))*(qpoch(q,l(2)))*(qpoch(q,l(3)))*(qpoch(q,l(4)))*(qpoch(q,l(5)))*(qpoch(q,l(6))));\n',coeffqnew, swapsnew, coeffznew);
    fprintf(fid, '            result = result + expr;\n');
    fprintf(fid, '        end\n');
    fprintf(fid, '        if any(i == checkPoints)\n');
    fprintf(fid, '            fprintf(''='');\n');
    fprintf(fid, '        end\n');
    fprintf(fid, '    end\n');
    fprintf(fid, '    fprintf('']\\n'');\n');
    fprintf(fid, '    disp(result);');

    
    % Close the file
    fclose(fid);
end
