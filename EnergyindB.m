% clc clear
% Energy in dB
%% Plotting the Energy in dB
[y Fs nbits] = wavread('c.wav');
subplot(411);
plot(y);
title('Original signal');

%% Normalizing y
y=y/max(abs(y));
subplot(412);
plot(y);
title('Normalized y');

%% Calculating Energy
E=y.*y;
subplot(413);
plot(E);
title('Energy');

%% Calculating Energy in dB
EdB=20*log10(E);
subplot(414);
plot(EdB);
title('Energy in dB');