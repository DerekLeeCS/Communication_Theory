function plotComplex( vec, label )

    plot( real( vec ), imag( vec ), label );
    xlabel( "Real" );
    ylabel( "Imaginary" );
    grid on;

end