clc
clear
close all

% Derek Lee
% Communication Theory Fall 2020
% Homework #1
% x, y, z functions are defined at the end of the file


%% Constants

N = 5000;       % Samples
T = 20;         % Seconds
fs = N/T;  
t = linspace( -T/2, T/2, N );
wd = linspace( -pi, pi, N );
f = wd*fs /( 2*pi );
fNaught = 1;
eps = 1e-10;    % Used for approx. equality


%% Question 5

% X(w)
x = funcX( fNaught, t );
X = fft( x );
Xs = fftshift( X/fs );

normSmallX = sum( abs( x.^2 ) ) * ( T/N );
normBigX = sum( abs( Xs.^2 ) ) * ( fs/N );

% Check if norms are equal ( accounting for MATLAB precision )
disp( "Parseval's Theorem is: " ) 
if abs( normSmallX - normBigX ) < eps
    disp( "True!" );
else
    disp( "False." );
end


%% Question 6

figure();
sgtitle( 'Question 6' );

% Magnitude
subplot(2,2,1);
plotMagnitude( f, Xs, 'X(w)' );

% Phase
subplot(2,2,2);
plotPhase( f, Xs, 'X(w)' );

% Y(w)
y = funcY( fNaught, t );
Y = fft( y );
Ys = fftshift( Y/fs );

% Magnitude
subplot(2,2,3);
plotMagnitude( f, Ys, 'Y(w)' );

% Phase
subplot(2,2,4);
plotPhase( f, Ys, 'Y(w)');


%% Question 7

% Z(w)
theta = pi/3;
z = funcZ( fNaught, t, theta );
Z = fft( z );
Zs = fftshift( Z/fs );

figure();
sgtitle( 'Question 7' );

% Magnitude
subplot( 2, 2, 1 );
plotMagnitude( f, Zs, 'Z(w)' );

% Phase
subplot( 2, 2, 2 );
plotPhase( f, Zs, 'Z(w)' );

% Bandpass
subplot( 2, 2, 3 );
plot( t, z );
title( 'Bandpass' );
xlabel( 'Time (s)' );
xlim( [ -T/2, 0 ] );

% Baseband
subplot( 2, 2, 4 );
plot( t, y );
title( 'Baseband' );
xlabel( 'Time (s)' );
xlim( [ -T/2, 0 ] );


%% Question 8

figure();
sgtitle( 'Question 8' );

% x
subplot( 3, 2, 1 );
[ hilbertFreqX, hilbertTimeX ] = hilbertTransform( wd, x );
plot( t, hilbertTimeX );
title( 'Hilbert Transform of x' );
xlabel( 'Time (s)' );

subplot( 3, 2, 2 );
plot( f, real( hilbertFreqX/fs ) );
title( 'Hilbert Transform of x' );
xlabel( 'Frequency (Hz)' );

% y
subplot( 3, 2, 3 );
[ hilbertFreqY, hilbertTimeY ] = hilbertTransform( wd, y );
plot( t, hilbertTimeY );
title( 'Hilbert Transform of y' );
xlabel( 'Time (s)' );

subplot( 3, 2, 4 );
plot( f, real( hilbertFreqY/fs ) );
title( 'Hilbert Transform of y' );
xlabel( 'Frequency (Hz)' );

% z
subplot( 3, 2, 5 );
[ hilbertFreqZ, hilbertTimeZ ] = hilbertTransform( wd, z );
plot( t, hilbertTimeZ );
title( 'Hilbert Transform of z' );
xlabel( 'Time (s)' );

subplot( 3, 2, 6 );
plot( f, real( hilbertFreqZ/fs ) );
title( 'Hilbert Transform of z' );
xlabel( 'Frequency (Hz)' );


%% Question 9

% All are close to 0 (probably non-zero b/c of MATLAB precision)
orthoX = dot( x, hilbertTimeX );
orthoY = dot( y, hilbertTimeY );
orthoZ = dot( z, hilbertTimeZ );

if abs( orthoX ) < eps
    disp( "Dot product of x and Hilbert transform is 0." )
end

if abs( orthoY ) < eps
    disp( "Dot product of y and Hilbert transform is 0." )
end

if abs( orthoZ ) < eps
    disp( "Dot product of z and Hilbert transform is 0." )
end


%% Functions

function x = funcX( fs, t )

    % Custom rect signal
    %   1, 0<=t<=1
    %   0, elsewhere
    T = 1;
    rect = t;
    rect( 0<=rect & rect<=T ) = 1;
    rect( rect~=1 ) = 0;

    % Multiplying by rect makes signal
    %   cos, 0<=t<=1
    %   0, elsewhere
    x = cos( 2*pi*fs*t ) .* rect;   
    
end

function y = funcY( fs, t )

    y = abs( funcX( fs, t+3 ) );
    
end

function z = funcZ( fs, t, theta )

    z = funcY( fs, t ) .* cos( 64*pi*t + theta );
    
end