function err_QAM = probErrorQAM(M, NUM_EXAMPLES , N_o, range)
    
    constellation_QAM = genQAM(M);
    symbols_QAM = genSyms( constellation_QAM, NUM_EXAMPLES); 
    
    % Calculate error
    err_QAM = probErrorNonDiff( constellation_QAM, symbols_QAM, N_o, range );
    
end

