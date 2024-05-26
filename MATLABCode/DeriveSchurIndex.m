function [result, unrefined] = DeriveSchurIndex(M,Range)
    Y_raw = null(M, 'rational');
    Rank = ((size(M,2) - size(Y_raw,2))/2);
    if isempty(Y_raw)
        disp("No flavour symmetry")
        result = NFS(M,10,Rank);
        unrefined = result;
        return
    end 
    disp("Flavour symmetry")
    [result, unrefined] = ONEFS(M,Range,Rank);
end