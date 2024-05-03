function result = NFS(M,Range,Rank)
    list = graphOrdering(M);
    plotgraph(M);
    generateFunction(M, list, Range);
    result = calculate_q_series_n_nodes_op(Range, Rank);
