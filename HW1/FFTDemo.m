%% Fourier Transforms in MATLAB
% All signals in MATLAB are discrete-time
clear; close all; clc;
N = 1024;% #samples
T = 1; % sec
fs = N/T;
t = linspace(-T/2,T/2,N);
y = [zeros(1,floor(N/2)-128),ones(1,floor(N/4)),zeros(1,floor(N/2)-128)];
figure;
plot(t,y)
xlabel("Time (s)")
title("y(t)")
ylim([-0.25,1.25])
%% FFT is like the sampled Discrete Fourier Transform
% output of FFT has same size as input
Y = fft(y);
figure;
plot(abs(Y))
title("Magnitude of FFT of Rect Function")
xlabel("Index")
%% This doesn't look like a sinc!
% FFT function puts the 0 frequency at the first index! The function
% fftshift is built to reorder the vector so that the center is the 0
% frequency (works by periodicity of the DTFT)
Ys = fftshift(Y);
figure;
plot(abs(Ys))
title("FFT with FFTshift")
xlabel("Index")
%% How do we interpret the x axis?
% One period of the DTFT, unshifted is 0 to 2pi, shifted is -pi to pi in
% DIGITAL RADIAN FREQUENCY wd = 2pif/fs
wd = linspace(-pi,pi,N);
fs = N/T;
f = wd*fs/(2*pi);
figure;
plot(f,abs(Ys))
title("Magnitude of Y(f)")
xlabel("Frequency (Hz)")
%% How about Inverse Fourier Transform?
% must take real part of ifft, as quantization -> not perfectly symmetric
% Apply ifft to UNSHIFTED version of Y!!! (without shifts, ifft and fft are
% inverses)
yi = real(ifft(Y));
figure;
plot(t,yi)
title("IFFT(FFT(y)) = y")
xlabel("Time (s)")
