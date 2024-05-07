function y = deriveflavourvectorONEFS(M)
    n = size(M, 1);
    A = zeros(n-1, n);
    for i = 2:n
        A(i-1, :) = M(i, :);
    end
    A = A(:, 2:end);  
    x = -A \ M(2:end, 1);
    y = [1; x];
end
