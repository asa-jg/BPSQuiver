function Y = deriveflavourvector(M, verbose)
    % This function finds all linearly independent solutions for the vector y
    % such that <y, yi> = 0 for all i, using the antisymmetric matrix M.
    % It returns as many solutions as the dimension of the null space of M.
    % If verbose is true, it prints out the solutions in a readable format.

    % Compute the null space of M
    Y_raw = null(M, 'rational');

    % Check if there are no independent solutions
    if isempty(Y_raw)
        error('No independent solutions exist.');
    end
    
    % Determine the number of solutions (columns in Y_raw)
    numSolutions = size(Y_raw, 2);

    % Initialize the output matrix for normalized vectors
    Y = zeros(size(Y_raw, 1), numSolutions);

    % Normalize each solution vector
    for k = 1:numSolutions
        % Find the index of the first nonzero coefficient
        idx = find(Y_raw(:, k), 1, 'first');
        % Normalize the vector so that the first nonzero coefficient is 1
        if Y_raw(idx, k) ~= 0
            Y(:, k) = Y_raw(:, k) / Y_raw(idx, k);
        end

        % Normalize further by dividing each vector by its max abs value to avoid overflow/underflow issues
        maxVal = max(abs(Y(:, k)));
        if maxVal > 0
            Y(:, k) = Y(:, k) / maxVal;
        end
    end

    % If verbose is true, print the solution vectors in a human-readable format
    if verbose
        fprintf('Solutions:\n');
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
                        fprintf('-y%d', i);
                    elseif coeff == 1
                        fprintf('y%d', i);
                    else
                        if coeff < 0
                            fprintf('%.2fy%d', coeff, i);
                        else
                            fprintf('%.2fy%d', coeff, i);
                        end
                    end
                end
            end
            fprintf('\n');
        end
    end

    % Return all independent solutions
    return
end
