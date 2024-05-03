function swapsnew = change(swaps)
    % Convert symbolic expression to string
    swapsStr = char(swaps);

    % Replace 'li' with 'l(i)' and 'ki' with 'k(i)'
    swapsStr = regexprep(swapsStr, 'l(\d+)', 'l($1)');
    swapsStr = regexprep(swapsStr, 'k(\d+)', 'l($1)');

    swapsnew = swapsStr;
end