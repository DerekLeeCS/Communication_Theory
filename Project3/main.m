clc
clear
close all

% Derek Lee, Steven Lee
% Communication Theory Fall 2020
% Project #3


%% Question 3

k = 4;

G_1 = [ 1,0,0,0,0,1,1,1;
        0,1,0,0,1,1,1,0;
        0,0,1,0,1,0,1,1;
        0,0,0,1,1,1,1,1 ];

n_1 = size( G_1, 2 );

G_2 = [ 1,0,0,0,1,1,1,1,0,1,1,0;
        0,1,0,0,1,0,0,1,1,1,1,0;
        0,0,1,0,1,1,0,1,1,0,1,1;
        0,0,0,1,1,0,1,0,1,1,1,1 ];

n_2 = size( G_2, 2 );


%% Question 4

% Convert to binary and reorder to columns
% 1 = 1000 -> 1 = 0001
numBits = 4;
range = de2bi( 0:2^numBits-1 );
range = flip( range, 2 );

% Generate the codewords
C_1 = multF2( range, G_1 );
C_2 = multF2( range, G_2 );

% Get max errors that can be corrected for each code
maxErrs_1 = calcHamming( C_1 );
maxErrs_2 = calcHamming( C_2 );


%% Question 5

% Get P for each generator matrix
P_1 = G_1( :, k+1:end );
P_2 = G_2( :, k+1:end );

% Create the parity check matrices
H_1 = [ P_1' eye(n_1-k) ];
H_2 = [ P_2' eye(n_2-k) ];

% Ensure G*H = 0
assert( sum( abs( multF2( G_1, H_1' ) ), 'all' ) == 0, "H_1 is not a valid parity check matrix" );
assert( sum( abs( multF2( G_2, H_2' ) ), 'all' ) == 0, "H_2 is not a valid parity check matrix" );


%% Question 6



%% Question 7




