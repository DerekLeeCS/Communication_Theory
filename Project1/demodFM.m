function signal_demod = demodFM( signal, Fs, f_carrier, f_cutoff, k )

    % Calculate constants
    w_carrier = 2*pi*f_carrier;
    M = ceil( 2*f_carrier/Fs ) + 5;
    [ N, ~ ] = size(signal);
    wd = linspace( -pi, pi, N )';
    f = wd*Fs*M /( 2*pi );
    
    % Multiply by jw (deriv)
    signal_fourier = fft( signal );
    signal_fourier = signal_fourier * 1j * 2*pi.*f / w_carrier;
    signal = real( ifft( signal_fourier ) );
    
    % Rectify, lowpass, decimate
    signal( signal<0 ) = 0;
    signal = decimate( lowpass( signal, f_cutoff, Fs*M ), M );

    signal_demod = signal;  % Should divide by 2*pi*k but gives terrible power

end