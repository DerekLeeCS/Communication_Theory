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
var = .05;
sig = sqrt( var );
P_m = bandpower( m );
f_noise_cutoff = bw;


%% Conventional AM

BASE_INDEX_MOD = 0.5;
INDEX_MOD = [ 0.5, 1, 2 ] * BASE_INDEX_MOD;
n = length( INDEX_MOD );

figure();
sgtitle( "Conventional AM" );

% Plot original
subplot( 2, 2, 1 );
semilogy( f, abs( fftshift( fft( m ) ) ) );
title( "Input" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );
    
for i = 1:n

    % Mod
    m_conventional = modConventional( m, Fs, amp_conventional_carrier, f_AM_carrier, INDEX_MOD(i) );

    % Add noise
    noise = sig * randn( length( m_conventional ), 1 );
    m_conventional_noise = m_conventional + noise;

    % Demod
    m_new = demodConventional( m_conventional_noise, Fs, f_AM_carrier, f_AM_cutoff );

    % Lowpass
    m_new = lowpass( m_new, f_noise_cutoff, Fs );
    
    % Plot
    subplot( 2, 2, 2 );
    title( "Modulated" );
    if i ~= 1
        hold on;
    end
    semilogy( f_AM_mod, abs( fftshift( fft( m_conventional ) ) ) );
    hold off;
    
    subplot( 2, 2, 3 );
    title( "Modulated + Noise" );
    if i ~= 1
        hold on;
    end
    semilogy( f_AM_mod, abs( fftshift( fft( m_conventional_noise ) ) ) );
    hold off;
    
    subplot( 2, 2, 4 );
    title( "Demodulated + Noise" );
    if i ~= 1
        hold on;
    end
    semilogy( f, abs( fftshift( fft( m_new ) ) ) );
    hold off;
    
    % SNR
    noiseless_conventional = demodConventional( m_conventional, Fs, f_AM_carrier, f_AM_cutoff );
    P_s = bandpower( noiseless_conventional );
    P_n = bandpower( m_new - noiseless_conventional );
    disp( "Conventional SNR (Mod Ind = " + INDEX_MOD(i) + "): " + pow2db( P_s/P_n ) );
    
    % Theoretical SNR
    N_o = 2*var;
    W = f_AM_cutoff / ( Fs*L_AM );
    SNR_conv = amp_conventional_carrier^2 * INDEX_MOD(i)^2 * P_m / ( 2*N_o*W );
    disp( "Theoretical Conventional SNR = " + pow2db( SNR_conv ) );

end

% Add labels to plots
for i = 2:4
    
    subplot( 2, 2, i );
    lgd = legend( [ "0.5*Index", "1*Index", "2*Index" ] );
    lgd.ItemTokenSize = [ 20, 15 ];
    xlabel( "Frequency (Hz)" );
    ylabel( "Magnitude (dB)" );
    
end


%% FM

BASE_k = 40000;
k = [ 0.5, 1, 2 ] * BASE_k;
n = length( k );

figure();
sgtitle( "FM" );
   
% Plot original
subplot( 2, 2, 1 );
semilogy( f, abs( fftshift( fft( m ) ) ) );
title( "Input" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );
    
for i = 1:n
  
    % Mod
    m_FM = modFM( m, Fs, amp_FM_carrier, f_FM_carrier, k(i) );

    % Add noise
    noise = sig * randn( length( m_FM ), 1 );
    m_FM_noise = m_FM + noise;
    
    % Demod
    m_new = demodFM( m_FM_noise, Fs, f_FM_carrier, f_FM_cutoff, k(i) );
    
    % Lowpass
    m_new = lowpass( m_new, f_noise_cutoff, Fs );
    
    % Plot    
    subplot( 2, 2, 2 );
    title( "Modulated" );
    if i ~= 1
        hold on;
    end
    semilogy( f_FM_mod, abs( fftshift( fft( m_FM ) ) ), 'DisplayName', "k = " + k(i) );
    hold off;
    
    subplot( 2, 2, 3 );
    title( "Modulated + Noise" );
    if i ~= 1
        hold on;
    end
    semilogy( f_FM_mod, abs( fftshift( fft( m_FM_noise ) ) ), 'DisplayName', "k = " + k(i) );
    hold off;

    subplot( 2, 2, 4 );
    title( "Demodulated + Noise" );
    if i ~= 1
        hold on;
    end
    semilogy( f, abs( fftshift( fft( m_new ) ) ), 'DisplayName', "k = " + k(i) );
    hold off;

    % SNR
    noiseless_FM = demodFM( m_FM, Fs, f_FM_carrier, f_FM_cutoff, k(i) );
    P_s = bandpower( noiseless_FM );
    P_n = bandpower( m_new - noiseless_FM );
    disp( "FM SNR (k = " + k(i) + "): " + pow2db( P_s/P_n ) );
    
    % Theoretical SNR
    N_o = 2*var;
    W = f_FM_cutoff / ( Fs*L_FM );
    SNR_FM = ( 3*amp_FM_carrier^2 ) * ( k(i)/f_noise_cutoff )^2 * P_m / ( 2*N_o*W );
    disp( "Theoretical FM SNR = " + pow2db( SNR_FM ) );

end

% Add labels to plots
for i = 2:4
    
    subplot( 2, 2, i );
    lgd = legend( [ "0.5*Index", "1*Index", "2*Index" ] );
    lgd.ItemTokenSize = [ 20, 15 ];
    xlabel( "Frequency (Hz)" );
    ylabel( "Magnitude (dB)" );
    
end


%% PM

BASE_k = 2;
k = [ 0.5, 1, 2 ] * BASE_k;
n = length( k );

figure();
sgtitle( "PM" );

% Plot original
subplot( 2, 2, 1 );
semilogy( f, abs( fftshift( fft( m ) ) ) );
title( "Input" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

for i = 1:n
    
    % Mod
    m_PM = modPM( m, Fs, amp_PM_carrier, f_PM_carrier, k(i) );
    
    % Add noise
    noise = sig * randn( length( m_PM ), 1 );
    m_PM_noise = m_PM + noise;

    % Demod
    m_new = demodPM( m_PM_noise, Fs, amp_PM_carrier, f_PM_carrier, f_PM_cutoff, k(i) );

    % Lowpass
    m_new = lowpass( m_new, f_noise_cutoff, Fs );

    % Plot    
    subplot( 2, 2, 2 );
    title( "Modulated" );
    if i ~= 1
        hold on;
    end
    semilogy( f_PM_mod, abs( fftshift( fft( m_PM ) ) ), 'DisplayName', "k = " + k(i) );
    hold off;
    
    subplot( 2, 2, 3 );
    title( "Modulated + Noise" );
    if i ~= 1
        hold on;
    end
    semilogy( f_PM_mod, abs( fftshift( fft( m_PM_noise ) ) ), 'DisplayName', "k = " + k(i) );
    hold off;
    
    subplot( 2, 2, 4 );
    title( "Demodulated + Noise" );
    if i ~= 1
        hold on;
    end
    semilogy( f, abs( fftshift( fft( m_new ) ) ), 'DisplayName', "k = " + k(i) );
    hold off;

    % SNR
    noiseless_PM = demodPM( m_PM, Fs, amp_PM_carrier, f_PM_carrier, f_PM_cutoff, k(i) );
    P_s = bandpower( noiseless_PM );
    P_n = bandpower( m_new - noiseless_PM );
    disp( "PM SNR (k = " + k(i) + "): " + pow2db( P_s/P_n ) );
    
    % Theoretical SNR
    N_o = 2*var;
    W = f_PM_cutoff / ( Fs*L_PM );
    SNR_PM = ( amp_PM_carrier^2 / 2 ) *  k(i)^2 * P_m / ( N_o*W );
    disp( "Theoretical PM SNR = " + pow2db( SNR_PM ) );
    
end

% Add labels to plots
for i = 2:4
    
    subplot( 2, 2, i );
    lgd = legend( [ "0.5*Index", "1*Index", "2*Index" ] );
    lgd.ItemTokenSize = [ 20, 15 ];
    xlabel( "Frequency (Hz)" );
    ylabel( "Magnitude (dB)" );
    
end


%% Play original sound

soundsc( m, Fs );


%% Test new sound

soundsc( m_new, Fs );


%% EMERGENCY STOP

clear sound;
