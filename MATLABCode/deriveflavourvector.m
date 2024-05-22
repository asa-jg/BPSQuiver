function Y = deriveflavourvector(M, verbose)
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

    % If verbose is true, print the solution vectors in a human-readable format
    if verbose
        for k = 1:numSolutions
            fprintf('yf%d = ', k);
            isFirst = true;
            for i = 1:length(Y(:, k))
                coeff = Y(i, k);
                if coeff ~= 0
                    if isFirst
                        isFirst = false;
                    else
                        if coeff > 0
                            fprintf(' + ');
                        end
                    end
                    
                    if coeff == -1
                        fprintf('- y%d', i);
                    elseif coeff == 1
                        fprintf('y%d', i);
                    else
                        fprintf('%.2fy%d', coeff, i);
                         
                    end
                end
            end
            fprintf('\n');
        end
    end

    % Return all independent solutions
    return
end