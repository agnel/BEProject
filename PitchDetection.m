function [f0] = PitchDetection(c, Fs)
%	Name: PitchDetection
%   Description: Function to compute short time Pitch Frequency;
%   Tags: Short time Pitch, Pitch Detection, Short-time Pitch detection
%   INPUTS:
%	@param	type: @vector		c:              size Nx1 which contains cepstrum coefficients. 
%	@param	type: @integer		Fs:             Sampling Rate of speech signal
%   OUTPUTS:
%   @param  type: @vector       f0:              Estimated Pitch
%   Author: Agnel Waghela.
%   Version: 1.1
%   Date: 2nd March, 2014
%   Dependencies: None

%% Searching for Maximum between 2ms(500Hz) and 20ms(50Hz)
ms2 = floor(Fs*0.002); % 2ms
ms20 = floor(Fs*0.02); % 20ms

%% find the maximum and the Index of the maximum
[~,idx] = max(abs(c(ms2:ms20))); % idx is the index of the peak and ~ is used because we do not need the magnitude of the peak
f0 = idx;