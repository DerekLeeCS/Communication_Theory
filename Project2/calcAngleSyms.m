function angle = calcAngleSyms( vec )

    angle = atan2( imag(vec), real(vec) ); 
    angle = diff( angle );
    
    % Transform (-pi,pi) -> (0,2*pi)
    angle( angle < 0 ) = angle( angle < 0 ) + 2*pi;
    
end