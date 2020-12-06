clc
clear
close all

% Brian Doan, Derek Lee, Steven Lee
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
range = de2bi( 0:2^k-1 );
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

cosetLeads_1 = zeros( 1, n_1 );
cosetLeads_1 = [ cosetLeads_1; genErrors( maxErrs_1, n_1 ) ];
cosetLeads_2 = zeros( 1, n_2 );
for numErrs = 1:maxErrs_2
    cosetLeads_2 = [ cosetLeads_2; genErrors( numErrs, n_2 ) ];
end
S_1 = genSyndrome( H_1, cosetLeads_1 );
S_2 = genSyndrome( H_2, cosetLeads_2 );

disp( "S_1 is " + ( 2^(n_1-k) - size( S_1, 1 ) ) + " smaller." );
disp( "S_2 is " + ( 2^(n_2-k) - size( S_2, 1 ) ) + " smaller." );


%% Question 7

% Test x random samples
samples = 10;
codes = C_2( randsample( size( C_2, 1 ), samples, 'true' ), : ); 
errs = cosetLeads_2( randsample( size( cosetLeads_2, 1 ), samples, 'true' ), : );

sent = addF2( codes, errs );

% Test correctable errors
for i = 1:samples
    corrected = correctWord( sent(i,:), cosetLeads_2, S_2, H_2 );
    assert( isequal( corrected, codes(i,:) ), ""+i );
end

disp( "Works!" );


%% Question 8

samples = 1e5;
points = 100;
probs = linspace( 0.001, 0.1, points );

% Generate words
uncoded = range( randsample( size( range, 1 ), samples, 'true' ), : ); 
coded_1 = multF2( uncoded, G_1 );
coded_2 = multF2( uncoded, G_2 );

% Create vector to store bit error rates
uncodedRate = zeros( 1, points );
codedRate_1 = zeros( 1, points );
codedRate_2 = zeros( 1, points );

for i = 1:points
    
    % Corrupt words
    corrupted_uncoded = corruptString( uncoded, probs(i) );
    corrupted_1 = corruptString( coded_1, probs(i) );
    corrupted_2 = corruptString( coded_2, probs(i) );
    
    % Attempt to correct errors
    corrected_1 = correctWord( corrupted_1, cosetLeads_1, S_1, H_1 );
    corrected_2 = correctWord( corrupted_2, cosetLeads_2, S_2, H_2 );

    % Calculate bit error rates
    uncodedRate(i) = calcBitErrRate( uncoded, corrupted_uncoded );
    codedRate_1(i) = calcBitErrRate( coded_1, corrected_1 );
    codedRate_2(i) = calcBitErrRate( coded_2, corrected_2 );

end


%% Plot Accuracies

figure();
hold on;
plot( probs, uncodedRate, 'DisplayName', 'Uncoded' );
plot( probs, codedRate_1, 'DisplayName', 'G_1' );
plot( probs, codedRate_2, 'DisplayName', 'G_2' );
hold off;
legend();
title( "Bit Error Rate vs. Bit Error Probability" );
xlabel( "Bit Error Probability" );
ylabel( "Bit Error Rate" );

