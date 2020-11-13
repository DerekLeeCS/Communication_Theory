function err = probErrorDiff( constellation, symbols, N_o, range )

    sz = length(range);
    err = zeros(1,sz);
    
    % Loop through each SNR value to calculate P(error)
    for SNR = range

        [ noisefree_scaled, receivedVec ] = scaleDiff( constellation, symbols, N_o, SNR );
        err( SNR-min(range)+1 ) = calcError( noisefree_scaled, receivedVec );

    end

end