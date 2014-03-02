%   Name: master
%   Description: Master Program For The Project
%   Tags: main, master
%   Author: Agnel Waghela
%   Version: 2.0
%   Date: 20 February, 2014
%   Dependencies: STE, ZCR, Cepstrum

%% Plotting the Original Signal
[y, Fs] = audioread('c.wav'); % 'wavread' will be removed from future releases, so 'audioread' is used
t = 1/Fs : 1/Fs : (length(y)/Fs);
subplot(311);
plot(t,y);
title('Original Speech Waveform');
xlabel('Time (seconds)');
ylabel('Amp');

%% Defining the Window Type, Window Size, Window Overlap Size
windowType = 'hm'; % 'hm' for Hamming, 'hn' for Hanning. For more See in the Function definition for STE.m
frame_size = 20;
frame_shift = 10;

%% Normalizing the Original signal
max_value = max(abs(y));
y = y/max_value;

%% Calculation and Plot of Short Time Energy
energy = STE(y, Fs, frame_size, frame_shift, windowType);
te = 1/Fs : (frame_shift/1000) : (length(energy)*(frame_shift/1000));
energy = energy/max(abs(energy));

subplot(312);
plot(te, energy, 'color', 'red');
title('Short Time Energy(STE)');
xlabel('Time (seconds)');
ylabel('Amp (Normalized)');

%% Calculation and Plot of Short Time Zero Crossing Rate
zero_crossing_rate = ZCR(y, Fs, frame_size, frame_shift, windowType);
tz = 1/Fs : (frame_shift/1000) : (length(zero_crossing_rate)*(frame_shift/1000));

subplot(313);
plot(tz, zero_crossing_rate, 'color', 'green');
title('Short Term Zero Crossing Rate(ZCR)');
xlabel('Time (seconds)');
ylabel('ZCR');

%% Calculation of Fundamental Frequency using Cepstrum

%% Computing Histogram, Local Maximas and Determination of Threshold for STE

%% Computing Histogram, Local Maximas and Determination of Threshold for ZCR

%% Distinction and creating final output