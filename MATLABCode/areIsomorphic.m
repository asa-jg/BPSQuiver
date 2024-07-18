function isomorphic = areIsomorphic(A, B)
    % Check if two adjacency matrices are isomorphic by brute force
    
    % Number of nodes
    n = size(A, 1);
    
    % Generate all possible permutations of node labels
    perm = perms(1:n);
    numPerms = size(perm, 1);
    
    for i = 1:numPerms
        % Get the current permutation
        p = perm(i, :);
        
        % Permute the rows and columns of A
        permutedA = A(p, p);
        
        % Check if the permuted A is equal tox1 B
        if isequal(permutedA, B)
            isomorphic = true;
            return;
        end
    end
    
    % If no permutation matches, the graphs are not isomorphic
    isomorphic = false;
end
