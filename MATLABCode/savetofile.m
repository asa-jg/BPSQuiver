Range = 4;
dimension = 4;
matrices = generateAdjacencyMatrices(dimension);
numMatrices = size(matrices, 3);
disp(numMatrices);
for i = 1:numMatrices
    M = matrices(:, :, i);
    try
        [result, unrefined] = DeriveSchurIndex(M, Range);
        appendDataToFile(M, result, unrefined);
    catch ME
        disp(['Error processing matrix ', num2str(i), ': ', ME.message]);
        % Optionally log the error or perform other actions
        continue; % Skip to the next iteration
    end
end