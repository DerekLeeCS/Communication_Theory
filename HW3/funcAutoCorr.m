function [ autocorr, PSD ] = funcAutoCorr( X, M, w )
    
    N = length( X );
    R_X = zeros( 2*M + 1, 1 );
    
    for m = -M:M
    
        if m<0
            
            scale = 1/(N-abs(m));
            R_X( m+M+1 ) = scale*dot( X(:, abs(m):N), X( :, 1:N+m+1 ) );
            
        else
            
            scale = 1/(N-m);
            R_X( m+M+1 ) = scale*dot( X(:, 1:N-m), X( :, m+1:N ) );
            
        end
        
        S_X = R_X( m+M+1 ) * exp( ( -1j * w * m ) / ( 2*M + 1 ) );
        
    end

    autocorr = R_X;
    PSD = S_X;
    
end