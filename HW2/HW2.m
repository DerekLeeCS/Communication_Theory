clc
clear
close all

% Derek Lee
% Communication Theory Fall 2020
% Homework #2


%% Import Audio

[ m, Fs ] = audioread( 'Carlton_Smith.mp3' );
numRows = size( m, 1 );

% Scale message
maxY = max( abs(m), [], 1 );
m = m ./ repmat( maxY, numRows, 1  );

% Take left channel
m = m( :, 1 );


%% Test Audio

sound = audioplayer( m, Fs );
%play( sound );


%% Constants

% Calculate time
maxTime = numRows / Fs;
t = linspace( 0, maxTime, numRows )';

wd = linspace( -pi, pi, numRows )';
f = wd*Fs /( 2*pi );


%% Question 1

figure();

% Time
subplot( 3, 1, 1 );
plot( t, m );
title( 'm(t)' );
xlabel( 'Time (s)' );

M = fft( m );
M = fftshift( M );

% Magnitude
subplot( 3, 1, 2 );
plotMagnitude( f, M, 'M(w)' );

% Phase
subplot( 3, 1, 3 );
plotPhase( f, M, 'M(w)' );

[ lower, upper ] = bandwidth( M );
mBandwidth = upper - lower;


%% Question 2

% Interpolation
SCALE_INTERP = 30;
interpM = interp( m, SCALE_INTERP );
Fs = Fs * 30;
t = linspace( 0, maxTime, numRows*SCALE_INTERP )';
wd = linspace( -pi, pi, numRows*SCALE_INTERP )';
f = wd*Fs /( 2*pi );

% 540 to 1700 kHz
f_carrier = 540 * 10^3;
w_carrier = 2*pi * f_carrier;
carrier = cos( w_carrier*t );


%% Question 3

% DSB-SC
dsbsc = interpM .* carrier;
DSBSC = fftshift( fft( dsbsc ) / Fs );

% DSB
A_p = 1;    % Pilot amplitude
dsb = ( A_p + interpM ) .* carrier;
DSB = fftshift( fft( dsb ) / Fs );

figure();

% Time
subplot( 2, 2, 1 );
plot( t, dsbsc );
title( 'DSB-SC' );
xlabel( 'Time (s)' );

subplot( 2, 2, 2 );
plot( t, dsb );
title( 'DSB' );
xlabel( 'Time (s)' );

% Frequency
subplot( 2, 2, 3 );
plotMagnitude( f, DSBSC, 'DSB-SC' );

subplot( 2, 2, 4 );
plotMagnitude( f, DSB, 'DSB' );

% DSB has a large spike (significantly higher than DSB-SC) at carrier
% frequency


%% Question 4

[ unused_, mHat ] = hilbertTransform( wd, interpM );

% LSSB
u_lssb = interpM .* cos( w_carrier * t ) + mHat .* sin( w_carrier * t );
U_LSSB = fftshift( fft( u_lssb ) / Fs );

% USSB
u_ussb = interpM .* cos( w_carrier * t ) - mHat .* sin( w_carrier * t );
U_USSB = fftshift( fft( u_ussb ) / Fs );

figure();

% Time
subplot( 2, 2, 1 );
plot( t, u_lssb );
title( 'Lower SSB' );
xlabel( 'Time (s)' );


subplot( 2, 2, 2 );
plot( t, u_ussb );
title( 'Upper SSB' );
xlabel( 'Time (s)' );


% Frequency
subplot( 2, 2, 3 );
plotMagnitude( f, U_LSSB, 'Lower SSB' );

subplot( 2, 2, 4 );
plotMagnitude( f, U_USSB, 'Upper SSB' );


%% Question 5
% Same as DSB b/c signal was scaled to 1 at the beginning?

% AM
A_p = 1;    % Pilot amplitude
am = ( A_p + interpM ) .* carrier;
AM = fftshift( fft( am ) / Fs );

figure();

% Time
subplot( 2, 1, 1 );
plot( t, am );
title( 'AM' );
xlabel( 'Time (s)' );

% Frequency
subplot( 2, 1, 2 );
plotMagnitude( f, AM, 'AM' );


%% Question 6

figure();

% Rectifier
am_rectified = abs( am );
AM_RECTIFIED = fftshift( fft( am_rectified ) / Fs );

    % Time
    subplot( 2, 2, 1 );
    plot( t, am_rectified );
    title( 'Rectified AM' );
    xlabel( 'Time (s)' );

    % Frequency
    subplot( 2, 2, 2 );
    plotMagnitude( f, AM_RECTIFIED, 'Rectified AM' );

% Low-pass Filter
fPass = 5000;
am_lowpass = lowpass( am_rectified, fPass, Fs );
AM_LOWPASS = fftshift( fft( am_lowpass ) / Fs );

    % Time
    subplot( 2, 2, 3 );
    plot( t, am_lowpass );
    title( 'Lowpass AM' );
    xlabel( 'Time (s)' );

    % Frequency
    subplot( 2, 2, 4 );
    plotMagnitude( f, AM_LOWPASS, 'Lowpass AM' );
   
    
%% Downsample
am_downsample = downsample( am_lowpass, SCALE_INTERP );
Fs = Fs / SCALE_INTERP;


%% Play sound

soundAM = audioplayer( am_downsample, Fs );
play( soundAM );


%% Functions

function plotMagnitude( f, signal, titleVar )
    
    semilogy( f, abs( signal ) );
    title( titleVar );
    xlabel( 'Frequency (Hz)' );
    ylabel( 'Magnitude' );
    
end

function plotPhase( f, signal, titleVar )

    plot( f, unwrap( angle( signal ) ) );
    title( titleVar );
    xlabel( 'Frequency (Hz)' );
    ylabel( 'Phase' );
    
end
