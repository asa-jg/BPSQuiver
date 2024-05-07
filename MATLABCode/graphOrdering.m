function orderedList = graphOrdering(adjMatrix)
    [sccs, condensedGraph] = findSCCs(adjMatrix);
    sortedSCCs = topologicalSort(condensedGraph);
    finalOrderedList = expandSortResult(sortedSCCs, sccs);
    orderedList = [-finalOrderedList, finalOrderedList];
end