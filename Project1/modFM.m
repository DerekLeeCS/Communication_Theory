function signal_FM = modFM( signal, Fs, amp_carrier, f_carrier, k )

    % Calculate constants
    w_carrier = 2*pi * f_carrier;
    L = ceil( 2*f_carrier/Fs ) + 5;
    [ N, ~ ] = size(signal);
    T = N/Fs;
    t_old = linspace( 0, T, N )';
    t_new = linspace( 0, T, N*L )';
    
    % Interpolate signal
    signal = interp1( t_old, signal, t_new );
    
    % Calculate phi
    phi = 2*pi*k * cumsum( signal )/(Fs*L);
    signal_FM = amp_carrier * ( cos( w_carrier * t_new + phi ) );

end