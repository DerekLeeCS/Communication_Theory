function signal_PM = modPM( signal, Fs, amp_carrier, f_carrier, k )

    % Calculate constants
    amp_pilot = 1;
    w_carrier = 2*pi * f_carrier;
    L = ceil( 2*f_carrier/Fs ) + 5;
    [ N, ~ ] = size(signal);
    T = N/Fs;
    t_old = linspace( 0, T, N )';
    t_new = linspace( 0, T, N*L )';
    
    % Interpolate signal
    signal = interp1( t_old, signal, t_new );
    
    % Calculate phi
    phi = k * signal;
    signal = amp_carrier * cos( w_carrier*t_new + phi );
    
    % Add pilot tone
    signal = signal + amp_pilot * cos( w_carrier*t_new );
    
    signal_PM = signal;
    
end