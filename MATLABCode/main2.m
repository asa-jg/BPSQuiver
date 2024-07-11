% MATLAB script to generate lists of all permutations of the numbers 1 2 3 4,
% ordered first by their negative counterparts and then by the positives

% Generate all permutations of 1 2 3 4
numbers = [1, 2, 3, 4];
perms_list = perms(numbers);

% Initialize a cell array to store the results
result = cell(size(perms_list, 1), 1);

% Loop through each permutation
for i = 1:size(perms_list, 1)
    % Get the current permutation
    perm = perms_list(i, :);
    
    % Create the corresponding list with negative and positive parts
    negative_part = -perm;
    positive_part = perm;
    combined_list = [negative_part, positive_part];
    
    % Store the combined list in the result cell array
    result{i} = combined_list;
end

% Display the results
for i = 1:length(result)
    disp(result{i});
end