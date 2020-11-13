function signal_demod = demodConventional( signal, Fs, f_carrier, f_cutoff )
    
    % Calculate constants
    M = ceil( 2*f_carrier/Fs ) + 5;
    
    % Rectify, lowpass, downsample
    signal( signal < 0 ) = 0;   
    signal = lowpass( signal, f_cutoff, Fs*M );
    signal = downsample( signal, M );

    signal_demod = signal;
    
end