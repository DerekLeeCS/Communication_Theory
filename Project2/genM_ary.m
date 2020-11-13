function constellation = genM_ary( M )

    angle_M_ary = linspace( 0, 2*pi, M+1 );
    angle_M_ary = angle_M_ary( 1:M );
    constellation = cos( angle_M_ary ) + 1j*sin( angle_M_ary );

end