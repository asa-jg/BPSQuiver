function [sccs, condensedGraph, nodeToSCC] = findSCCs(adjMatrix)
    G = digraph(adjMatrix);
    [bins, ~] = conncomp(G, 'Type', 'strong');
    numSCCs = max(bins);
    sccs = arrayfun(@(x) find(bins == x), 1:numSCCs, 'UniformOutput', false);
    nodeToSCC = bins;
    condensedGraph = zeros(numSCCs);
    for i = 1:numSCCs
        for j = 1:numSCCs
            if any(any(adjMatrix(bins == i, bins == j))) && i ~= j
                condensedGraph(i, j) = 1;
            end
        end
    end
end