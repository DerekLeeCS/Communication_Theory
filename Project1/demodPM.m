function signal_demod = demodPM( signal, Fs, amp_carrier, f_carrier, f_cutoff, k )

    w_carrier = 2*pi * f_carrier;
    M = ceil( 2*f_carrier/Fs ) + 5;
    [ N, ~ ] = size(signal);
    T = N/(Fs*M);
    t = linspace( 0, T, N )';

    signal = signal .* sin( w_carrier * t );
    
    % Lowpass, downsample 
    signal = lowpass( signal, f_cutoff, Fs*M );
    signal = downsample( signal, M );
    
    signal_demod = signal/k * (2/amp_carrier);
    
end