function kroneckerDeltaStr = generateKroneckerConditions(sortedList)
    kroneckerDeltaStr = 'if ';
    n = size(sortedList, 1);
    
    i = 1;
    while i <= n
        j = i;
        currentPos = {};
        currentNeg = {};

        % Find end of current sequence with the same first element
        while j < n && sortedList(j, 1) == sortedList(j + 1, 1)
            j = j + 1;
        end
        
        % Process all elements from i to j
        for k = i:j
            [pos, neg] = parseTerms(sortedList(k, 2));
            currentPos = [currentPos, pos{:}];
            currentNeg = [currentNeg, neg{:}];
        end

        % Create a condition string for the collected terms
        if ~isempty(currentPos) && ~isempty(currentNeg)
            condition = sprintf('%s == %s', strjoin(currentPos, ' + '), strjoin(currentNeg, ' + '));
            kroneckerDeltaStr = [kroneckerDeltaStr condition, ' and '];
        end
        
        % Move to the next sequence
        i = j + 1;
    end
    
    % Remove the trailing ' and ' if it exists
    if endsWith(kroneckerDeltaStr, ' and ')
        kroneckerDeltaStr = extractBefore(kroneckerDeltaStr, strlength(kroneckerDeltaStr) - 4);
    end
end



function [posParts, negParts] = parseTerms(term)
    posParts = {};
    negParts = {};
    
    % Normalize expression for easier handling
    term = strrep(char(term), ' ', '');  % Remove spaces for consistent processing
    term = regexprep(term, '\-', ' -'); % Ensure space before every minus for split
    term = regexprep(term, '\+', ' +'); % Ensure space before every plus for split
    
    % Split terms based on spaces introduced
    parts = strsplit(term, ' ');

    % Classify each part as positive or negative
    for part = parts
        if isempty(part{1})
            continue;
        end
        if startsWith(part{1}, '-')
            % Negative term
            negParts{end+1} = part{1}(2:end);  % Strip the '-' sign
        else
            % Positive term, may have a leading '+'
            cleanedPart = strrep(part{1}, '+', '');
            posParts{end+1} = cleanedPart;
        end
    end
end
