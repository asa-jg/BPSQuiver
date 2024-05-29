function result = NFS(M,Range)
    Y_raw = null(M, 'rational');
    M(M < 0) = 0;
    list = graphOrdering(M);
    plotgraph(M);
    Rank = ((size(M,2) - size(Y_raw,2))/2);
    generateMainFuncWLNFS(M, Range, Rank, list);
    generateFunction(M, list, Range);
    tic;
    command = 'math -script scriptNFS.wl';
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
