function plotPhase( f, signal, titleVar )

    plot( f, unwrap( angle( signal ) ) );
    title( titleVar );
    xlabel( 'Frequency (Hz)' );
    ylabel( 'Phase' );
    
end