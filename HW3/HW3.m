clc
clear
close all

% Derek Lee
% Communication Theory Fall 2020
% Homework #3


%% Question 6

% Generate white noise
M = 5000;
N = 50000;
variance = 10000;
noise = sqrt(variance) * randn( N, 1 );

% Frequency
w = linspace( -1000, 1000, 5000 );

[ autocorr, PSD ] = funcAutoCorr( noise', M, w );

figure();

% Plotting
subplot( 2, 1, 1 );
stem( -M:M, autocorr );
title( "Autocorrelation of White Noise" );
xlabel( "m" );


%% Question 7

% PSD
subplot( 2, 1, 2 );
semilogy( w, abs(PSD) );
title( "PSD of White Noise" );
xlabel( "w" );


%% Question 8

Y = sqrt(variance) * randn( N, 1 );
Z = sqrt(variance) * randn( N, 1 );
w_o = 10000;
t = linspace( 0, 1000, N )';
X = Y .* cos( w_o*t ) - Z .* sin( w_o*t );

figure();

% PSD of X
[ autocorrX, PSDX ] = funcAutoCorr( X', M, w );

subplot( 2, 1, 1 );
semilogy( w, abs(PSDX) );
title( "PSD of X" );
xlabel( "w" );

% PSD of Integral of X
PSDIntegralX = ( 1./w ).^2 .* PSD;

subplot( 2, 1, 2 );
semilogy( w, abs(PSDIntegralX) );
title( "PSD of Integral of X" );
xlabel( "w" );
