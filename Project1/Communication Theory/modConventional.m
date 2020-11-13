function signal_mod = modConventional( signal, Fs, amp_carrier, f_carrier, index_mod )
    
    % Calculate constants
    amp_pilot = 1;
    w_carrier = 2*pi * f_carrier;
    L = ceil( 2*f_carrier/Fs ) + 5;
    [ N, ~ ] = size(signal);
    T = N/Fs;
    t_old = linspace( 0, T, N )';
    t_new = linspace( 0, T, N*L )';

    % Change modulation index to given argument
    signal = signal * index_mod; 
    
    % Interpolate signal
    signal = interp1( t_old, signal, t_new );
    signal = amp_carrier * ( amp_pilot + signal ) .* cos( w_carrier * t_new );

    signal_mod = signal;
    
end