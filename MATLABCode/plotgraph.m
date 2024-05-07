function plotgraph(M)
    % Initialize variables to store the source and target of edges
    sources = [];
    targets = [];

    % Loop through each element in the matrix                           
    for i = 1:size(M, 1)
        for j = 1:size(M, 2)
            if M(i, j) ~= 0
                % Add edges based on the value at M(i, j)
                sources = [sources; repmat(i, M(i, j), 1)];
                targets = [targets; repmat(j, M(i, j), 1)];
            end
        end
    end

    % Create a directed graph
    G = digraph(sources, targets);

    % Create custom node labels
    numNodes = size(M, 1);
    nodeLabels = arrayfun(@(x) ['\gamma_{' num2str(x) '}'], 1:numNodes, 'UniformOutput', false);

    % Plot the graph with custom node labels        
    plot(G, 'Layout', 'force', 'NodeLabel', nodeLabels);
end
