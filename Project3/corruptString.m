function corrupted = corruptString( true, probError )

    [ N, M ] = size( true );
    
    % Generates a vector of 1's and 0's
    %   1's are generated with P( probError )
    errs = ( rand( N,M ) <= probError );
    corrupted = addF2( true, errs );
    
end