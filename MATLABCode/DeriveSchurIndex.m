function DeriveSchurIndex(M,Range,Rank)
    Y_raw = null(M, 'rational');
    if isempty(Y_raw)
        disp("No flavour symmetry")
        NFS(M,Range,Rank);
        return
    end 
    disp("Flavour symmetry")
    ONEFS(M,Range,Rank);
end