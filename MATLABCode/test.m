function test(M,Range)
    Rank = size(M,2)/2;
    list = graphOrdering(M);
    generateFunction(M, list, Range);
    calculate_q_series_n_nodes_op(Range, Rank)
