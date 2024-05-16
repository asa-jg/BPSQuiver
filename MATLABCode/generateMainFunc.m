function generateMainFunc(M, Range)
    % Define the path and name of the file
    fileName = 'mainfunc.m';
    len = size(M,1);
    [qresult, zresult, newkron] = superloop(M);
    disp(qresult);
    disp(zresult);
    qresultnew = changeflavour(qresult,len);
    zresultnew = changeflavour(zresult,len);
   
    % Open the file for writing
    fid = fopen(fileName, 'w');
    
    % Handle error in file opening
    if fid == -1
        error('Failed to open file for writing.');
    end
    
    % Write the function signature and the initial declarations
    fprintf(fid, 'function result = mainfunc()\n');
    fprintf(fid, '    syms q;\n');
    fprintf(fid, '    result = sym(0);\n');
    fprintf(fid, '    q = sym(''q'');\n');
    fprintf(fid, '    z1 = sym(''z1'');\n');
    fprintf(fid, '    z2 = sym(''z2'');\n');
    fprintf(fid, '    z3 = sym(''z3'');\n');
    fprintf(fid, '    z4 = sym(''z4'');\n');
    fprintf(fid, '    z5 = sym(''z5'');\n');    
    
    % Grid generation and combination setup
    fprintf(fid, '    gridPoints = cell(1, %d);\n',2*len);
    fprintf(fid, '    [gridPoints{:}] = ndgrid(0:%d);\n',Range);
    fprintf(fid, '    combinations = cellfun(@(x) x(:), gridPoints, ''UniformOutput'', false);\n');
    fprintf(fid, '    combinations = [combinations{:}];\n');
    fprintf(fid, '    totalCombinations = size(combinations, 1);\n');
    
    % Progress initialization
    fprintf(fid, '    fprintf(''\\nProgress: ['');\n');
    fprintf(fid, '    progressSteps = 3;\n');
    fprintf(fid, '    checkPoints = linspace(1, totalCombinations, progressSteps+1);\n');
    
    % Writing the parallel for loop
    fprintf(fid, '    parfor i = 1:totalCombinations\n');
    fprintf(fid, '        l = combinations(i, :);\n');
    fprintf(fid, '        %s\n',newkron);
    fprintf(fid, '            sum_exponent = 1/2*(sum(l)) + %s;\n', qresultnew);
    fprintf(fid, '            z_term = %s;\n',zresultnew);
    fprintf(fid, '            denominator = prod(arrayfun(@(x) qpoch(q, x), l));\n');
    fprintf(fid, '            expr = (q^sum_exponent) * z_term / denominator;\n');
    fprintf(fid, '            result = result + (-1)^(sum(l)) * expr;\n');
    fprintf(fid, '        end\n');
    fprintf(fid, '        if any(i == checkPoints)\n');
    fprintf(fid, '            fprintf(''='');\n');
    fprintf(fid, '        end\n');
    fprintf(fid, '    end\n');
    fprintf(fid, '    fprintf(''] %% Complete\\n'');\n');

    % Close the function
    fprintf(fid, 'end\n');

    % Close the file
    fclose(fid);
end
