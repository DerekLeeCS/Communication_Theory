clc
clear
close all

% Derek Lee
% Communication Theory Fall 2020
% Homework #5


%% Question 1

% Raised Cosine
alpha = 0.5;
T = 10;
syms w
X_rc = piecewise( ( 0 <= abs(w) ) & ( abs(w) <= pi*(1-alpha)/T ), ...
                        T, ...
                  ( pi*(1-alpha)/T <= abs(w) ) & ( abs(w) <= pi*(1+alpha)/T ), ...
                        (T/2) * ( 1 + cos( T/(2*alpha) * (abs(w) - pi*(1-alpha)/T ) ) ), ...
                  abs(w) > pi*(1+alpha)/T, ...
                        0 );

% Plot the function
testPoints = linspace( -pi*(1+alpha)/T, pi*(1+alpha)/T, 100 );
X = subs( X_rc, w, testPoints );

figure();
plot( testPoints, X );
title( "Raised Cosine (\alpha=" + alpha + ", T=" + T + ")" );
xlabel( "\omega (rads)" );
ylabel( "X_{rc}", 'rotation', 0, 'Units', 'Normalized', 'Position', [-0.075, 0.5, 0] );


%% Question 4

% Calculate entropy using probabilities
probs = [ 1/16, 1/16, 1/4, 1/32, 3/32, 1/8, 1/16, 5/16 ];
entropy = sum( -probs.*log2(probs) );


%% Question 5

symbols = 1:8;
[dict,avglen] = huffmandict( symbols, probs );


%% Question 7

G = [ 0,1,1,1,0,1,1;
      1,0,0,1,1,1,1;
      0,0,1,1,1,0,1 ];
  
e = [ 1,0,0;
      0,1,0;
      0,0,1 ];
  
g = e * G;

[k,n] = size(G);


%% Question 8

% Convert to binary and reorder to columns
% 1 = 100 -> 1 = 001
range = de2bi( 0:n );
range(:,[1,3]) = range(:,[3,1]);

C = range * g;
C = mod(C,2);

% Get distances for each codeword
D = pdist(C);
minDist = min(D)^2;
Z = squareform(D);
disp( "The minimum distance is: " + minDist );


%% Question 10

P = [ 1,1,1,1;
      0,1,1,0;
      1,1,0,1 ];
    
G_S = [ eye(k) P ];
    

%% Question 11

H = [ P' eye(n-k) ];


%% Question 12

GH = G*H';
GH = mod(GH,2);
G_SH = G_S*H';
G_SH = mod(G_SH,2);

disp( "Total sum of GH is: " + sum(GH,'all') );
disp( "Total sum of G_SH is: " + sum(G_SH,'all') );

