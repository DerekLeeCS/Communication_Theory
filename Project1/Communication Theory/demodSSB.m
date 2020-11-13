function signal_demod = demodSSB( signal, Fs, amp_carrier, f_carrier, f_cutoff )

    % Calculate constants
    w_carrier = 2*pi * f_carrier;
    M = ceil( 2*f_carrier/Fs ) + 5;
    [ N, ~ ] = size(signal);
    T = N/(Fs*M);
    t = linspace( 0, T, N )';
    
    % Calculate pilot signal and mix
    signal_pilot = amp_carrier * cos( w_carrier * t );
    signal = signal .* signal_pilot;

    % Lowpass, downsample 
    signal = lowpass( signal, f_cutoff, Fs*M );
    signal = downsample( signal, M ); 
    
    signal_demod = signal;
    
end