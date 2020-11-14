clc
clear
close all

% Derek Lee
% Communication Theory Fall 2020
% Project #2


%% Constants

NUM_EXAMPLES = 1e5; % Number of symbols


%% Question 1

tic

constellation = [ 1, -1, 1j, -1j ];
var = 0.1;  % Might be too high & causes error

% Symbols to transmit
symbols = genSyms( constellation, NUM_EXAMPLES );
noise = sqrt(var) * ( randn( 1, length(symbols) ) + 1j*randn( 1, length(symbols) ) );
symbols_noisy = symbols + noise;

disp( "Calculating Question #1" )
estimates = LSNonDiff( constellation, symbols_noisy );

errNonDiff = calcError( symbols, estimates );
disp( "Error for NonDiff: " + errNonDiff );

disp( "Time required to computed Question 1" );
toc


%% Question 2

tic

N_o = 10;
SNRBit = 20;

disp( "Calculating Question #2 NonDiff" )
[ noisefree_scaled, receivedVec ] = scaleNonDiff( constellation, symbols, N_o, SNRBit );
errNonDiff = calcError( noisefree_scaled, receivedVec );
disp( "Error for NonDiff: " + errNonDiff );

disp( "Calculating Question #2 Diff" )
[ transmitted_D, received_D ] = scaleDiff( constellation, symbols, N_o, SNRBit );     
errDiff = calcError( transmitted_D, received_D );
disp( "Error for Diff: " + errDiff );

disp( "Time required to computed Question 2:" );
toc


%% Question 5

tic

N_o = 10;        % Noise power
range = -4:20;  % Range of SNRs to loop through (in dB)
sz = length(range);

err_binary_AP_theoretical = zeros(1,sz);
err_binary_ortho_theoretical = zeros(1,sz);

% Binary Antipodal
constellation_anti = [1j, -1j];
symbols_anti = genSyms( constellation_anti, NUM_EXAMPLES );
    
% Binary Orthogonal
constellation_ortho = [1, 1j];
symbols_ortho = genSyms( constellation_ortho, NUM_EXAMPLES );

err_binary_AP = probErrorNonDiff( constellation_anti, symbols_anti, N_o, range );
err_binary_ortho = probErrorNonDiff( constellation_ortho, symbols_ortho, N_o, range );

% Loop through each SNR value to calculate P(error)
M = length( constellation_anti );

for SNR = range
    
    E_s = db2pow(SNR) * N_o * floor( log2(M) );
    
    err_binary_AP_theoretical( SNR-min(range)+1 ) = qfunc( sqrt( 2*E_s/N_o ) );
    err_binary_ortho_theoretical( SNR-min(range)+1 ) = qfunc( sqrt( 1*E_s/N_o ) );
    
end

% Plot
figure();
hold on;
plot( range, err_binary_AP, '.-', 'Color', 'red', 'DisplayName', 'Antipodal' );
plot( range, err_binary_ortho, '.-', 'Color', 'green', 'DisplayName', 'Orthogonal' );
plot( range, err_binary_AP_theoretical, '.-', 'Color', 'blue', 'DisplayName', 'Theoretical Antipodal' );
plot( range, err_binary_ortho_theoretical, '.-', 'Color', 'magenta', 'DisplayName', 'Theoretical Orthogonal' );
title( 'Question 5' );
xlabel( 'SNR/bit (dB)' );
ylabel( 'P(error)' );
legend();
hold off;

disp( "Time required to computed Question 5:" );
toc


%% Question 6

tic

M = [ 4, 8, 16, 32 ];

figure();
hold on;

for i = 1:length(M)

    err_nonDiff_M_ary = probErrorNonDiffM_ary( M(i), NUM_EXAMPLES, N_o, range );
    plot( range, err_nonDiff_M_ary, '.-', 'DisplayName', "M="+M(i) );
    
end

% Plot
title( 'Question 6' );
xlabel( 'SNR/bit (dB)' );
ylabel( 'P(error)' );
legend();
hold off;
    
disp( "Time required to computed Question 6:" );
toc


%% Question 7

tic

figure();
hold on;

for i = 1:length(M)
    
    err_diff_M_ary = probErrorDiffM_ary( M(i), NUM_EXAMPLES, N_o, range );
    plot( range, err_diff_M_ary, '.-', 'DisplayName', "M="+M(i) );
    
end

% Plot
title( 'Question 7' );
xlabel( 'SNR/bit (dB)' );
ylabel( 'P(error)' );
legend();
hold off;

disp( "Time required to computed Question 7:" );
toc


%% Question 8

tic

M = [ 4, 16, 32, 64 ];

figure();
hold on;

for i = 1:length(M)
    
    err_QAM = probErrorQAM( M(i), NUM_EXAMPLES, N_o, range );
    plot( range, err_QAM, '.-', 'DisplayName', "M="+M(i) );
    
end

% Plot
title( 'Question 8' );
xlabel( 'SNR/bit (dB)' );
ylabel( 'P(error)' );
legend();
hold off;

disp( "Time required to computed Question 8:" );
toc

