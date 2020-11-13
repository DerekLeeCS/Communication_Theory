clc
close all

% Communication Theory Fall 2020
% Project #1
% Derek Lee

% Frequencies are in Hz
% Run this after running main.m
% Otherwise, copy/paste the constants over


%% Constants

% Noise
var = [ .01, .05, .1 ];
sig = sqrt( var );
n = length( sig );
f_noise_cutoff = bw;
P_m = bandpower( m );


%% Conventional AM

INDEX_MOD = 1;

figure( 'Position', [ 100, 100, 750, 750 ] );
t = tiledlayout( 4, 3 );
t.Title.String = "Conventional AM";

% Original Signal
nexttile( [1 3] );
semilogy( f, abs( fftshift( fft( m ) ) ) );
title( "Input" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

% Mod
nexttile( [1 3] );
m_conventional = modConventional( m, Fs, amp_conventional_carrier, f_AM_carrier, INDEX_MOD );
semilogy( f_AM_mod, abs( fftshift( fft( m_conventional ) ) ) );
title( "Modulated" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

for i = 1:n

    % Add noise
    noise = sig(i) * randn( length( m_conventional ), 1 );
    m_conventional_noise = m_conventional + noise;

    % Demod
    m_new = demodConventional( m_conventional_noise, Fs, f_AM_carrier, f_AM_cutoff );

    % Lowpass
    m_new = lowpass( m_new, f_noise_cutoff, Fs );
    
    % Plot
    nexttile();
    semilogy( f_AM_mod, abs( fftshift( fft( m_conventional_noise ) ) ) );
    title( "Modulated + Noise (Var = " + var(i) + ")" );
    xlabel( "Frequency (Hz)" );
    ylabel( "Magnitude (dB)" );

    nexttile(9+i);
    semilogy( f, abs( fftshift( fft( m_new ) ) ) );
    title( "Demodulated + Noise (Var = " + var(i) + ")" );
    xlabel( "Frequency (Hz)" );
    ylabel( "Magnitude (dB)" );
    
    % SNR
    noiseless_conventional = demodConventional( m_conventional, Fs, f_AM_carrier, f_AM_cutoff );
    P_s = bandpower( noiseless_conventional );
    P_n = bandpower( m_new - noiseless_conventional );
    disp( "Conventional SNR (Var = " + var(i) + "): " + pow2db( P_s/P_n ) );

    % Theoretical SNR
    N_o = 2*var(i);
    W = f_AM_cutoff / ( Fs*L_AM );
    SNR_conv = amp_conventional_carrier^2 * INDEX_MOD^2 * P_m / ( 2*N_o*W );
    disp( "Theoretical Conventional SNR = " + pow2db( SNR_conv ) );
    
end


%% SSB AM

figure( 'Position', [ 100, 100, 750, 750 ] );
t = tiledlayout( 4, 3 );
t.Title.String = "SSB AM";

% Original Signal
nexttile( [1 3] );
semilogy( f, abs( fftshift( fft( m ) ) ) );
title( "Input" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

% Mod
nexttile( [1 3] );
m_SSB = modSSB( m, Fs, amp_SSB_carrier, f_AM_carrier );
semilogy( f_AM_mod, abs( fftshift( fft( m_SSB ) ) ) );
title( "Modulated" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

for i = 1:n

    % Add noise
    noise = sig(i) * randn( length( m_SSB ), 1 );
    m_SSB_noise = m_SSB + noise;

    % Demod
    m_new = demodSSB( m_SSB_noise, Fs, amp_SSB_carrier, f_AM_carrier, f_AM_cutoff );

    % Lowpass
    m_new = lowpass( m_new, f_noise_cutoff, Fs );
    
    % Plot
    nexttile();
    semilogy( f_AM_mod, abs( fftshift( fft( m_SSB_noise ) ) ) );
    title( "Modulated + Noise (Var = " + var(i) + ")" );
    xlabel( "Frequency (Hz)" );
    ylabel( "Magnitude (dB)" );
    
    nexttile(9+i);
    semilogy( f, abs( fftshift( fft( m_new ) ) ) );
    title( "Demodulated + Noise (Var = " + var(i) + ")" );
    xlabel( "Frequency (Hz)" );
    ylabel( "Magnitude (dB)" );
        
    % SNR
    noiseless_SSB = demodSSB( m_SSB, Fs, amp_SSB_carrier, f_AM_carrier, f_AM_cutoff );
    P_s = bandpower( noiseless_SSB );
    P_n = bandpower( m_new - noiseless_SSB );
    disp( "SSB SNR (Var = " + var(i) + "): " + pow2db( P_s/P_n ) );
    
    % Theoretical SNR
    N_o = 2*var(i);
    W = f_AM_cutoff / ( Fs*L_AM );
    SNR_SSB = amp_SSB_carrier^2 * P_m / ( N_o*W );
    disp( "Theoretical SSB SNR = " + pow2db( SNR_SSB ) );

end


%% FM

k = 40000;

figure( 'Position', [ 100, 100, 750, 750 ] );
t = tiledlayout( 4, 3 );
t.Title.String = "FM";

% Original Signal
nexttile( [1 3] );
semilogy( f, abs( fftshift( fft( m ) ) ) );
title( "Input" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

% Mod
nexttile( [1 3] );
m_FM = modFM( m, Fs, amp_FM_carrier, f_FM_carrier, k );
semilogy( f_FM_mod, abs( fftshift( fft( m_FM ) ) ) );
title( "Modulated" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

for i = 1:n
  
    % Add noise
    noise = sig(i) * randn( length( m_FM ), 1 );
    m_FM_noise = m_FM + noise;
    
    % Demod
    m_new = demodFM( m_FM_noise, Fs, f_FM_carrier, f_FM_cutoff, k );
    
    % Lowpass
    m_new = lowpass( m_new, f_noise_cutoff, Fs );
    
    % Plot
    nexttile();
    semilogy( f_FM_mod, abs( fftshift( fft( m_FM_noise ) ) ) );
    title( "Modulated + Noise (Var = " + var(i) + ")" );
    xlabel( "Frequency (Hz)" );
    ylabel( "Magnitude (dB)" );
    
    nexttile(9+i);
    semilogy( f, abs( fftshift( fft( m_new ) ) ) );
    title( "Demodulated + Noise (Var = " + var(i) + ")" );
    xlabel( "Frequency (Hz)" );
    ylabel( "Magnitude (dB)" );
    
    % SNR
    noiseless_FM = demodFM( m_FM, Fs, f_FM_carrier, f_FM_cutoff, k );
    P_s = bandpower( noiseless_FM );
    P_n = bandpower( m_new - noiseless_FM );
    disp( "FM SNR (Var = " + var(i) + "): " + pow2db( P_s/P_n ) );
    
    % Theoretical SNR
    N_o = 2*var(i);
    W = f_FM_cutoff / ( Fs*L_FM );
    SNR_FM = ( 3*amp_FM_carrier^2 ) * ( k/f_noise_cutoff )^2 * P_m / ( 2*N_o*W );
    disp( "Theoretical FM SNR = " + pow2db( SNR_FM ) );

end


%% PM

k = 2;

figure( 'Position', [ 100, 100, 750, 750 ] );
t = tiledlayout( 4, 3 );
t.Title.String = "PM";

% Original Signal
nexttile( [1 3] );
semilogy( f, abs( fftshift( fft( m ) ) ) );
title( "Input" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

% Mod
nexttile( [1 3] );
m_PM = modPM( m, Fs, amp_PM_carrier, f_PM_carrier, k );
semilogy( f_PM_mod, abs( fftshift( fft( m_PM ) ) ) );
title( "Modulated" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

for i = 1:n
    
    % Add noise
    noise = sig(i) * randn( length( m_PM ), 1 );
    m_PM_noise = m_PM + noise;

    % Demod
    m_new = demodPM( m_PM_noise, Fs, amp_PM_carrier, f_PM_carrier, f_PM_cutoff, k );

    % Lowpass
    m_new = lowpass( m_new, f_noise_cutoff, Fs );

    % Plot    
    nexttile();
    semilogy( f_PM_mod, abs( fftshift( fft( m_PM_noise ) ) ) );
    title( "Modulated + Noise (Var = " + var(i) + ")" );
    xlabel( "Frequency (Hz)" );
    ylabel( "Magnitude (dB)" );
    
    nexttile(9+i);
    semilogy( f, abs( fftshift( fft( m_new ) ) ) );
    title( "Demodulated + Noise (Var = " + var(i) + ")" );
    xlabel( "Frequency (Hz)" );
    ylabel( "Magnitude (dB)" );
    
    % SNR
    noiseless_PM = demodPM( m_PM, Fs, amp_PM_carrier, f_PM_carrier, f_PM_cutoff, k );
    P_s = bandpower( noiseless_PM );
    P_n = bandpower( m_new - noiseless_PM );
    disp( "PM SNR (Var = " + var(i) + "): " + pow2db( P_s/P_n ) );
    
    % Theoretical SNR
    N_o = 2*var(i);
    W = f_PM_cutoff / ( Fs*L_PM );
    SNR_PM = ( amp_PM_carrier^2 / 2 ) *  k^2 * P_m / ( N_o*W );
    disp( "Theoretical PM SNR = " + pow2db( SNR_PM ) );

end


%% Play original sound

soundsc( m, Fs );


%% Test new sound

soundsc( m_new, Fs );


%% EMERGENCY STOP

clear sound;

