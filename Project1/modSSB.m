function signal_SSB = modSSB( signal, Fs, amp_carrier, f_carrier )

    % Calculate constants
    amp_pilot = 1;
    w_carrier = 2*pi * f_carrier;
    L = ceil( 2*f_carrier/Fs ) + 5;
    [ N, ~ ] = size(signal);
    T = N/Fs;
    t_old = linspace( 0, T, N )';
    t_new = linspace( 0, T, N*L )';
    wd = linspace( -pi, pi, N*L )';
    f = wd*Fs*L /( 2*pi );

    % Interpolate signal
    signal = interp1( t_old, signal, t_new );
    
    % Calculate USSB
    [ ~, signal_hat ] = hilbertTransform( f, signal ); 
    signal_USSB = amp_carrier * ( signal .* cos( w_carrier * t_new ) - signal_hat .* sin( w_carrier * t_new ) );
    
    % Add pilot tone
    signal_pilot = amp_pilot * cos( w_carrier * t_new );
    signal_SSB = signal_USSB + signal_pilot;    

end
