function result = qpoch(q, n)
    % Vectorized q-Pochhammer calculation
    k = 1:n;
    result = prod(1 - q.^k);
end