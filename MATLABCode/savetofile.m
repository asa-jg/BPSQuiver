function savetofile(matrices, range, numMatricesToProcess, fileName)
    Range = range;
    numMatrices = size(matrices, 3);

    % Display total number of matrices
    disp(numMatrices);

    % Set of processed indices
    processedIndices = false(1, numMatricesToProcess);

    % Counter for the number of processed matrices
    processedCount = 0;

    % Loop until the desired number of matrices have been processed
    while processedCount < numMatricesToProcess
        % Choose a random index between 1 and the total number of matrices
        randomIndex = randi(numMatricesToProcess);

        % Check if this index has already been processed
        if ~processedIndices(randomIndex)
            % Mark this index as processed
            processedIndices(randomIndex) = true;
            processedCount = processedCount + 1;

            % Retrieve the matrix
            M = matrices(:, :, randomIndex);

            % Try to process the matrix and append data to the file
            try
                result = DeriveSchurIndexWL(M, Range);
                appendDataToFile(M, result, fileName);
                disp(processedCount);
            catch ME
                disp(['Error processing matrix ', num2str(randomIndex), ': ', ME.message]);
                continue; % Skip to the next iteration
            end
        end
    end
end


