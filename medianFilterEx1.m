clc
[y Fs] = audioread('c.wav');
% normalizing speech signal
y = y/max(abs(y));
t = 1/Fs : 1/Fs : length(y)/Fs;
E = y.*y;

subplot(211);
plot(t,E);
title('Original Signal');

% Applying median filter to energy signal
E = medfilt1(E,5);
E = medfilt1(E,5);
subplot(212);
plot(t,E);
title('Energy After applying median filter 1');