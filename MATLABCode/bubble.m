function [sortedList, counter] = bubble(FinalOrdering, TARGET, M)
    % Initialize the sortedList with FinalOrdering
    n = size(FinalOrdering, 1);
    sortedList = FinalOrdering;
    
    % Initialize the symbolic counter
    counter = sym(0);
    
    % Create a mapping from TARGET values to their indices for quick reference
    targetMap = zeros(1, max(TARGET));
    for i = 1:length(TARGET)
        if TARGET(i) <= length(targetMap) % Ensure TARGET index is within the map range
            targetMap(TARGET(i)) = i;
        end
    end
    
    % Bubble sort algorithm with swap interactions and logging
    madeSwap = true;
    while madeSwap
        madeSwap = false;
        for i = 1:n-1
            % Compare elements based on their TARGET order
            if targetMap(sortedList(i, 1)) > targetMap(sortedList(i + 1, 1))
                % Swap elements if they are out of order
                temp = sortedList(i, :);
                sortedList(i, :) = sortedList(i + 1, :);
                sortedList(i + 1, :) = temp;
                
                % Access matrix M to get the value for the multiplication
                matrixValue = - M(sortedList(i, 1), sortedList(i+1, 1));
                
                % Update the counter with the product of secondary elements multiplied by matrixValue
                counterUpdate = matrixValue * sortedList(i, 2) * sortedList(i + 1, 2);
                counter = counter + counterUpdate;
                
                % Log the swap and counter update
                
                madeSwap = true;
            end
        end
    end
%disp(sortedList);
end
