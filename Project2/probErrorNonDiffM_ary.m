function err_M_ary = probErrorNonDiffM_ary( M, NUM_EXAMPLES, N_o, range )

    % Calculate constellation and generate symbols
    constellation_M_ary = genM_ary( M );
    symbols_M_ary = genSyms( constellation_M_ary, NUM_EXAMPLES );

    % Calculate error
    err_M_ary = probErrorNonDiff( constellation_M_ary, symbols_M_ary, N_o, range );

end