function orderedList = graphOrderingFS(adjMatrix)
    adjMatrix(adjMatrix < 0) = 0;
    [sccs, condensedGraph] = findSCCs(adjMatrix);
    sortedSCCs = topologicalSort(condensedGraph);
    finalOrderedList = expandSortResult(sortedSCCs, sccs);
    orderedList = finalOrderedList;
end