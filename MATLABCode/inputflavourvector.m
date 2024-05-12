function [sortedInputList, counter] = inputflavourvector(INPUTLIST, ORDERLIST, M)
    % Initialize the symbolic counter
    counter = sym(0);
 
    % Modify ORDERLIST by removing '1' and duplicating remaining elements
    modifiedOrderList = repmat(ORDERLIST(ORDERLIST ~= 1), 1, 2);

    % Initialize the sorted list as the INPUTLIST initially
    sortedInputList = INPUTLIST;

    % Convert sortedInputList to an array of labels for easier processing
    labels = cellfun(@(x) x(1), sortedInputList);
    expressions = cellfun(@(x) x(2), sortedInputList, 'UniformOutput', false);

    % Perform the bubble sort
    n = length(labels);
    for i = 1:n
        madeSwap = false;
        for j = 1:n-i
            % Find index of labels[j] and labels[j+1] in modifiedOrderList
            currentLabelIndex = find(modifiedOrderList == labels(j), 1);
            nextLabelIndex = find(modifiedOrderList == labels(j+1), 1);
            
            % Swap if current label comes after the next label in order list
            if currentLabelIndex > nextLabelIndex
                % Update counter with the product of matrix entry and the expressions
                matrixValue = M(labels(j), labels(j+1));
                counter = counter + matrixValue * expressions{j} * expressions{j+1};
                
                % Perform the swap
                [sortedInputList{j}, sortedInputList{j+1}] = deal(sortedInputList{j+1}, sortedInputList{j});
                [labels(j), labels(j+1)] = deal(labels(j+1), labels(j));
                [expressions(j), expressions(j+1)] = deal(expressions(j+1), expressions(j));
                madeSwap = true;
            end
        end
        % Break early if no swaps were made in this pass
        if ~madeSwap
            break;
        end
    end
end