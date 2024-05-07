function sortedSCCs = topologicalSort(condensedGraph)
    G = digraph(condensedGraph);
    sortedSCCs = toposort(G, 'Order', 'stable');
end
