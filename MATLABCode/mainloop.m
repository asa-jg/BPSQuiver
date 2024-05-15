function counter = mainloop(M)
    FinalOrdering = createFinalOrder(M);
    TARGET = graphOrderingFS(M);
    [sortedList, counter] = bubble(FinalOrdering, TARGET, M);
    kroneckerCondition = generateKroneckerConditions(sortedList);
    disp(kroneckerCondition);
    %disp(counter);
    %fprintf('flavour vector: '); 
    %deriveflavourvector(M, true);
    end