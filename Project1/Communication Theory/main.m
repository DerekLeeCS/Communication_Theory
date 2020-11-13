clc
clear
close all

% Communication Theory Fall 2020
% Project #1
% Derek Lee

% Frequencies are in Hz


%% Load audio

[ m, Fs ] = audioread( 'Carlos_Herrera.mp3' );
m = m( :, 1 );  % Take one channel
m = m / max( m ); % Normalize
N = length(m);
wd = linspace( -pi, pi, N )';
f = wd*Fs / ( 2*pi );
T_original = ( N/Fs );
t_original = linspace( 0, T_original, N ); 

% Plot
figure();
t = tiledlayout( 1, 2 );
t.Title.String = "Original";

nexttile();
plot( t_original, m );
title( "Time Domain" );
xlabel( "Time (s)" );
ylabel( "Magnitude" );

nexttile();
semilogy( f, abs( fftshift( fft( m ) ) ) );
title( "Frequency Domain" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

% Calculate power
disp( "Original Power: " + bandpower( m ) );


%% Constants

% Carrier amplitudes
amp_conventional_carrier = .184;
amp_SSB_carrier = .118;
amp_FM_carrier = 1.46;
amp_PM_carrier = 2.27;

% AM
f_AM_carrier = 800*1000;
f_AM_cutoff = Fs/2;

% FM
f_FM_carrier = 1000*1000;
f_FM_cutoff = Fs/2;

% PM
f_PM_carrier = 1000*1000;
f_PM_cutoff = Fs/2;

L_AM = ceil( 2*f_AM_carrier/Fs ) + 5;
L_FM = ceil( 2*f_FM_carrier/Fs ) + 5;
L_PM = ceil( 2*f_PM_carrier/Fs ) + 5;

% t for signal
t_AM_mod = linspace( 0, T_original, N*L_AM ); 
t_FM_mod = linspace( 0, T_original, N*L_FM ); 
t_PM_mod = linspace( 0, T_original, N*L_PM ); 

% f for modulated signal
wd_AM = linspace( -pi, pi, N*L_AM )';
wd_FM = linspace( -pi, pi, N*L_FM )';
wd_PM = linspace( -pi, pi, N*L_PM )';

f_AM_mod = wd_AM*Fs*L_AM / ( 2*pi );
f_FM_mod = wd_FM*Fs*L_FM / ( 2*pi );
f_PM_mod = wd_PM*Fs*L_PM / ( 2*pi );

% Bandwidth
bw = obw( m, Fs );


%% Conventional AM

INDEX_MOD = 1;

% Mod
m_conventional = modConventional( m, Fs, amp_conventional_carrier, f_AM_carrier, INDEX_MOD );

% Demod
m_new = demodConventional( m_conventional, Fs, f_AM_carrier, f_AM_cutoff );

% Plot
figure();
t = tiledlayout( 1, 2 );
t.Title.String = "Conventional AM Modulated";

nexttile();
plot( t_AM_mod, m_conventional );
title( "Time Domain" );
xlabel( "Time (s)" );
ylabel( "Magnitude" );

nexttile();
semilogy( f_AM_mod, abs( fftshift( fft( m_conventional ) ) ) );
title( "Frequency Domain" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

% Calculate power
disp( "Conventional Power: " + bandpower( m_new ) );


%% SSB AM

% Mod
m_SSB = modSSB( m, Fs, amp_SSB_carrier, f_AM_carrier );

% Demod
m_new = demodSSB( m_SSB, Fs, amp_SSB_carrier, f_AM_carrier, f_AM_cutoff );

% Plot
figure();
t = tiledlayout( 1, 2 );
t.Title.String = "SSB AM Modulated";

nexttile();
plot( t_AM_mod, m_SSB );
title( "Time Domain" );
xlabel( "Time (s)" );
ylabel( "Magnitude" );

nexttile();
semilogy( f_AM_mod, abs( fftshift( fft( m_SSB ) ) ) );
title( "Frequency Domain" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" )

% Calculate power
disp( "SSB Power: " + bandpower( m_new ) );


%% FM

k = 40000;

% Mod
m_FM = modFM( m, Fs, amp_FM_carrier, f_FM_carrier, k );

% Demod
m_new = demodFM( m_FM, Fs, f_FM_carrier, f_FM_cutoff, k );

% Plot
figure();
t = tiledlayout( 1, 2 );
t.Title.String = "FM Modulated";

nexttile();
plot( t_FM_mod, m_FM );
title( "Time Domain" );
xlabel( "Time (s)" );
ylabel( "Magnitude" );

nexttile();
semilogy( f_FM_mod, abs( fftshift( fft( m_FM ) ) ) );
title( "Frequency Domain" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

% Calculate power
disp( "FM Power: " + bandpower( m_new ) );


%% PM

k = 2;

% Mod
m_PM = modPM( m, Fs, amp_PM_carrier, f_PM_carrier, k );

% Demod
m_new = demodPM( m_PM, Fs, amp_PM_carrier, f_PM_carrier, f_PM_cutoff, k );

% Plot
figure();
t = tiledlayout( 1, 2 );
t.Title.String = "PM Modulated";

nexttile();
plot( t_PM_mod, m_PM );
title( "Time Domain" );
xlabel( "Time (s)" );
ylabel( "Magnitude" );

nexttile();
semilogy( f_PM_mod, abs( fftshift( fft( m_PM ) ) ) );
title( "Frequency Domain" );
xlabel( "Frequency (Hz)" );
ylabel( "Magnitude (dB)" );

% Calculate power
disp( "PM Power: " + bandpower( m_new ) );



%% Play original sound

soundsc( m, Fs );


%% Test new sound

soundsc( m_new, Fs );


%% EMERGENCY STOP

clear sound;

