Range = 8;
%matrices = generateAdjacencyMatrices(dimension);
numMatrices = size(matrices, 3);
disp(numMatrices);
num = 0;
for i = 1:numMatrices
    M = matrices(:, :, i);
    Y_raw = null(M, 'rational');
    if isempty(Y_raw)
        try
            result = DeriveSchurIndexWL(M, Range);
            appendDataToFile(M, result);
        catch ME
            disp(['Error processing matrix ', num2str(i), ': ', ME.message]);
            continue; % Skip to the next iteration
        end
    end
end
