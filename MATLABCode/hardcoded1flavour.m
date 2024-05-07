function expr = hardcoded1flavour(n)
    syms z q;
    expr = sym(0);
    for l1 = 0:n
        for l2 = 0:n
            for l3 = 0:n
                for l4 = 0:n
                    for l5 = 0:n
                        for l6 = 0:n
                            if l1 + l3 == l4 + l6 && l5 + l6 == l2 + l3
                                expr = expr + ((-1)^(l1 + l2 + l3 + l4 + l5 + l6)*q^((1/2)*(l1 + l2 + l3 + l4 + l5 + l6)+-(l1 - l4)^2/2+ l1*l5 + l3*l5 + l1*l6)*z^(2*(l1 - l4)))/(qpoch(q,l1)*(qpoch(q,l2))*(qpoch(q,l3))*(qpoch(q,l4))*(qpoch(q,l5))*(qpoch(q,l6)));
                            end
                        end
                    end
                end
            end
        end
    end

