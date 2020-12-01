function minDist = calcMinDist( C )

    % Can calculate using calcMinWeight( xor( A, B ) )
    %   but using a built-in function instead.
    D = pdist( C, 'hamming' );
    minDist = min(D) * size( C, 2 );

end