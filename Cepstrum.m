function [c] = Cepstrum(speechSamples, windowType)
%	Name: Cepstrum
%   Description: Function to compute short time Cepstrum for detection of fundamental frequency
%   Tags: Short time Cepstrum, Cepstrum, Short-time Cepstrum
%   INPUTS:
%	@param	type: @vector		speechSignal:   The Actual Speech signal
%	@param	type: @string		windowType:     type of window used. 're' for Rectangular, 'hm' for Hamming, 'hn' for Hanning
%   OUTPUTS:
%   @param  type: @vector       c:              Complex Cepstrum of the Signal
%   Author: Agnel Waghela.
%   Version: 1.1
%   Date: 27 February, 2014
%   Dependencies: None

%% Storing the Arguments
y = speechSamples;

%% Set Window length same as length of given Speech Samples
windowLength = length(y);

%% Check if windowType Variable exist
if isempty(windowType)
     w = 're';
end

% if ischar(window)
%      window   = eval(sprintf('%s(nsample)', window)); % e.g., hamming(n) where window = 'hamming';
%  end

%% Determing the Type of Window to be used
switch(windowType)
    case 'hm'
        w = hamming(windowLength);
    case 'hn'
        w = hanning(windowLength);
    case 're'
        w = rectwin(windowLength);
    otherwise
        w = rectwin(windowLength);
end

%% Apply window on the Given Speech Samples
yWin = y .* w;

%% Calculate Complex Cepstrum
yfft = fft(y,windowLength);
c = ifft(log(abs(y)),windowLength);
