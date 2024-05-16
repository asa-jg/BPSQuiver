function DeriveSchurIndex(M,Range,Rank)
    Y_raw = null(M, 'rational');
    if isempty(Y_raw)
        NFS(M,Range,Rank);
        return
    end 
    ONEFS(M,Range,Rank)
end