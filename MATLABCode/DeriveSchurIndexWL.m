function result = DeriveSchurIndexWL(M,Range)
    tic;
    Y_raw = null(M, 'rational');
    Rank = ((size(M,2) - size(Y_raw,2))/2);
    if isempty(Y_raw)
        disp("No flavour symmetry")
        result = NFS(M,Range);
        return
    end 
    disp("Flavour symmetry")
    generateMainFuncWL(M,Range,Rank);
    tic;
    command = 'math -script script.wl';
    [status, cmdout] = system(command);
    result = cmdout;
    if status == 0
        disp('Schur Index:');
        disp(cmdout);
    else
        disp('Error running Mathematica script:');
        disp(cmdout);
    end
    toc;
end