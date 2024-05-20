command = 'math  -script  mathematicaScript.wl';

% Execute the command
[status, cmdout] = system(command);

% Display the output
disp(cmdout);