function res = countswaps(M, input)
    % This function calculates the exponent of q after multiple commutations
    % when taking the trace of the KS operator.
    % M is the adjacency matrix for the digraph representing the BPS
    % Quiver.
    % input is the list representing the original order of the
    % generators.

    n = length(input) / 2;  % The list must have 2n elements.
    res = sym(0);

    % Generate the target list based on the first half of the input list
    target = zeros(1, 2*n);
    for i = 1:n
        target(2*i-1) = input(i);
        target(2*i) = -input(i);
    end

    % Generate symbolic labels based on the absolute values in the input list
    secondary = cell(2*n, 2);
    for i = 1:(2*n)
        absValue = abs(input(i));
        labelPrefix = 'k';
        if input(i) > 0
            labelPrefix = 'l';
        end
        secondary{i, 1} = input(i);
        secondary{i, 2} = sym([labelPrefix, num2str(absValue)]);
    end

    % Bubble sort according to the target list
    for i = 1:(2*n)
        for j = 1:(2*n - i)
            current = find(target == input(j));
            next = find(target == input(j + 1));
            if current > next
                [input(j), input(j + 1)] = deal(input(j + 1), input(j));
                [secondary{j, 1}, secondary{j + 1, 1}, secondary{j, 2}, secondary{j + 1, 2}] = deal(secondary{j + 1, 1}, secondary{j, 1}, secondary{j + 1, 2}, secondary{j, 2});

                row = abs(secondary{j, 1});  
                col = abs(secondary{j + 1, 1});
                mv = M(row, col);
                res = res + mv * secondary{j, 2} * secondary{j + 1, 2};
            end
        end
    end
end
