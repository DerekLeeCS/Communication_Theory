clc
clear
close all

% Derek Lee
% Communication Theory Fall 2020
% Homework #4


%% Question 8

p_error = 1/10;
A = 1;                              % For simplicity
k_B = 1.38 * 1e-23; 
T = 298;                            % Kelvins
rateResistance = 52.7 * 1e-3;       % Ohms per meter
LIGHT_YEAR = 9.4607 * 1e15;         % Light year in meters
MILKYWAY = 100000;                  % Number of light years in the Milky Way

z = qfuncinv( p_error );

L = ( 2.5^2 * A ) / ( 4*k_B*T * rateResistance * z^2 );

L_LY = L/LIGHT_YEAR;
L_MW = L_LY/MILKYWAY;

disp( "Wire is " + L_LY + " light years long." );
disp( "Wire would have to be " + L_MW + " Milky Ways long." );

