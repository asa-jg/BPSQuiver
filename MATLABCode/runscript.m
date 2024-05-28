% MATLAB script to run Mathematica script and print result to console
% Define the command to run the Mathematica script
tic;
command = 'math -script script.wl';

% Run the command and capture the output
[status, cmdout] = system(command);

% Check if the command was successful
if status == 0
    % Print the output to the MATLAB console
    disp('Output from Mathematica script:');
    disp(cmdout);
else
    % Print the error message
    disp('Error running Mathematica script:');
    disp(cmdout);
end

toc;
