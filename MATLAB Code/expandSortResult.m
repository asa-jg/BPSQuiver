function orderedList = expandSortResult(sortedSCCs, sccs)
    orderedList = horzcat(sccs{sortedSCCs});
end