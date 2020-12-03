function bitErrRate = calcBitErrRate( true, predicted )

    bitErrs = abs( true - predicted );
    bitErrs( isnan( bitErrs ) ) = 1;
    bitErrRate = sum( bitErrs, 'all' ) / numel( true );
    
end