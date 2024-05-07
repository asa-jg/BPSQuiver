function expr = su2char(n)
    syms z;
    m = n - 1;
    expr = sym(0); 
    
    for k = m:-2:-m
        if k == 0
            expr = expr + 1; 
        else
            expr = expr + z^k; 
        end
    end
end
