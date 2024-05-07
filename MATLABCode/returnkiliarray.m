function outputArray = returnkiliarray(inputArray)
    % Initialize the output array as a cell array of the same size as the input
    outputArray = cell(size(inputArray));
    
    % Loop through each element of the input array
    for i = 1:numel(inputArray)
        % Apply returnkili to each element and store the result in the output array
        try
            outputArray{i} = returnkili(inputArray{i});
        catch ME
            % Handle errors gracefully, possibly by leaving the output as empty or setting a default value
            outputArray{i} = []; % Or any default/error value you prefer
            fprintf('Error processing element %d: %s\n', i, ME.message);
        end
    end
end
