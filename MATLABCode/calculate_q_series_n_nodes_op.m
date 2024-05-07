function result = calculate_q_series_n_nodes_op(exponent, r)
    syms q
    new(q) = hardcoded_generalfunc(exponent);
    disp("calculating taylor series...")
    taylorgeneral = taylor_series(new,exponent);
    qinfnew = qinf^r;
    result_int = (multiply(taylorgeneral,qinfnew));
    result = truncate(result_int,exponent+1);
    disp(result)
end