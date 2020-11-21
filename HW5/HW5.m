clc
clear
close all

% Derek Lee
% Communication Theory Fall 2020
% Homework #5


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

