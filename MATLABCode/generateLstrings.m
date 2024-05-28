function [varString, rangeString] = generateLstrings(n)
    % Generate the list of variables {l1, l2, ..., l2n}
    vars = arrayfun(@(i) sprintf('l%d', i), 1:2*n, 'UniformOutput', false);
    
    % Generate the list of ranges {l1, range}, {l2, range}, ..., {l2n, range}
    ranges = arrayfun(@(i) sprintf('{l%d, range}', i), 1:2*n, 'UniformOutput', false);
    
    % Convert the lists to strings
    varString = ['{', strjoin(vars, ', '), '}'];
    rangeString = strjoin(ranges, ', ');
end
