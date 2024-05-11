function Y = deriveflavourvector(M)
    % Compute the null space of M
    Y_raw = null(M, 'rational');
    
    if isempty(Y_raw)
        error('No independent solutions exist.');
    end
    numSolutions = size(Y_raw, 2);
    Y = zeros(size(Y_raw, 1), numSolutions);
    for k = 1:numSolutions
        idx = find(Y_raw(:, k), 1, 'first');
        if Y_raw(idx, k) ~= 0
            Y(:, k) = Y_raw(:, k) / Y_raw(idx, k);
        end
        maxVal = max(abs(Y(:, k)));
        if maxVal > 0
            Y(:, k) = Y(:, k) / maxVal;
        end
    end
    return
end
