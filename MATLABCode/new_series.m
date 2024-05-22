function taylorExpansion = new_series(f, n)
     % Ensure that Symbolic Math Toolbox is available
    assert(~isempty(ver('symbolic')), 'Symbolic Math Toolbox is required.');

    % Define a symbolic variable
    syms q;

    % Calculate the Taylor series expansion
    taylorExpansion = series(f(q), q, 'ExpansionPoint', 0, 'Order', n + 1);

    %display(taylorExpansion);
end 