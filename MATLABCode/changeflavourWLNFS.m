function swapsnew = changeflavourWLNFS(swaps)
    % Convert symbolic expression to string if not already a char
    swapsStr = char(swaps);
    
    % Find all instances of 'li' and extract the numeric part
    liMatches = regexp(swapsStr, 'l(\d+)', 'match');
    % Determine the maximum value of 'i' found in 'li'


    if ~isempty(liMatches)
        swapsStr = regexprep(swapsStr, 'l(\d+)', 'l[[$1]]');
    end
    % Manually calculate replacements for 'ki' with 'k(n+i)'
    kiMatches = regexp(swapsStr, 'k(\d+)', 'match');
    for i = 1:length(kiMatches)
        kiVal = str2double(kiMatches{i}(2:end)); % Extract numerical part and convert
        replacement = sprintf('l[[%d]]', kiVal); % Calculate replacement text
        swapsStr = strrep(swapsStr, kiMatches{i}, replacement); % Perform replacement
    end

    swapsnew = swapsStr;
end
