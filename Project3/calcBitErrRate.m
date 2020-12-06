function bitErrRate = calcBitErrRate( true, predicted )

    % Only check the message
    true = true(:, 1:4);
    predicted = predicted(:, 1:4);
    
    % Calculate the error
    bitErrs = abs( true - predicted );
    bitErrs( isnan( bitErrs ) ) = 1;
    bitErrRate = sum( bitErrs, 'all' ) / numel( true );

end