function orderedList = graphOrderingFS(adjMatrix)
    [sccs, condensedGraph] = findSCCs(adjMatrix);
    sortedSCCs = topologicalSort(condensedGraph);
    finalOrderedList = expandSortResult(sortedSCCs, sccs);
    orderedList = finalOrderedList;
end