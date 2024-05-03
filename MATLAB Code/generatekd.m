function resultStr = generatekd(inputData)
    % Initialize an empty string to build the result
    resultStr = 'if ';

    if isa(inputData, 'cell')
        % Handle as cell array
        processCellArray(inputData);
    elseif isa(inputData, 'sym')
        % Handle as symbolic matrix
        processSymbolicMatrix(inputData);
    elseif ischar(inputData) || isstring(inputData)
        % Handle as character string representing a symbolic matrix
        inputData = strrep(inputData, '[', ''); % Remove starting bracket
        inputData = strrep(inputData, ']', ''); % Remove ending bracket
        rows = strsplit(inputData, ';'); % Split into rows
        
        for i = 1:length(rows)
            expressions = strsplit(strtrim(rows{i}), ',');
            lhs = strtrim(expressions{1});
            rhs = strtrim(expressions{2});
            resultStr = concatCondition(resultStr, lhs, rhs, i > 1);
            
        end
    else
        error('Input must be either a cell array, a symbolic matrix, or a character/string representation of a matrix.');
    end
    
    % Nested function to process cell array
    function processCellArray(inputCell)
        numRows = size(inputCell, 1);
        for i = 1:numRows
            lhs = inputCell{i, 1};
            rhs = inputCell{i, 2};
            resultStr = concatCondition(resultStr, lhs, rhs, i > 1);
        end
    end
    
    % Nested function to process symbolic matrix
    function processSymbolicMatrix(symMatrix)
        [numRows, numCols] = size(symMatrix);
        
        for i = 1:numRows
            lhs = symMatrix(i, 1);
            rhs = symMatrix(i, 2);
            resultStr = concatCondition(resultStr, lhs, rhs, i > 1);
        end
    end
end

function resultStr = concatCondition(resultStr, lhs, rhs, isNotFirst)
    % Ensure both sides are converted to strings
    lhsStr = char(lhs);
    rhsStr = char(rhs);
    
    if isNotFirst
        resultStr = [resultStr ' && '];
    end
    
    resultStr = [resultStr, lhsStr, ' == ', rhsStr];
end
