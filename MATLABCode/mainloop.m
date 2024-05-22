function [counter,newkron] = mainloop(M)
    [FinalOrdering,~, ~] = createFinalOrder(M);
    len = size(M,1);
    TARGET = graphOrderingFS(M);
    [sortedList, counter] = bubble(FinalOrdering, TARGET, M);
    kroneckerCondition = generateKroneckerConditions(sortedList);
    newkron = changeflavour(kroneckerCondition,len);
    %disp(newkron);
    %disp(counter);
    fprintf('Flavour vector(s): '); 
    fprintf('\n');
    deriveflavourvector(M, true);
    end