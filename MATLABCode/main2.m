% Define the adjacency matrix M
M = [0 1 1; -1 0 -1; -1 1 0;];


% Define symbolic expressions (assuming k1, k2, k3, l1, l2, l3 are defined)
exp1 = str2sym('k1 - l1');
exp2 = str2sym('-k1 + l1');
exp3 = str2sym('-k3 + l3');
exp4 = str2sym('-k2 + l2');

% Define INPUTLIST with labels and expressions
INPUTLIST = {[2, exp1], [3, exp2], [3, exp3], [2, exp4]};

% Define ORDERLIST with labels
ORDERLIST = [1, 3, 2];

% Call the customBubbleSortWithMatrix function
[sortedInputList, counter] = customBubbleSort(INPUTLIST, ORDERLIST, M);

% Display the sorted list and the counter
disp(sortedInputList);
disp(counter);