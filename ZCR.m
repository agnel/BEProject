function [c] = ZCR(speechSignal, Fs, frameSize, frameShift, windowType)
%	Name: ZCR
%   Description: Function to plot speech wave form and compute short time zero crossing rate
%   Tags: Short Time ZCR, ZCR, Short-time ZCR
%	@param	type: @array		speechSignal: The Actual Speech signal
%	@param	type: @integer		Fs: Sampling Rate of speech signal
%	@param	type: @integer		frameSize: Window size(in milliseconds)
%	@param	type: @integer		frameShift: Window Overlapping(in milliseconds)
%	@param	type: @string		windowType: type of window used. 're' for Rectangular, 'hm' for Hamming, 'hn' for Hanning
%   Author: Agnel Waghela.
%   Version: 2.0
%   Date: 2nd March, 2014.
%   Dependencies: None

%% Storing the Arguments
y = speechSignal;

frameSize = frameSize/1000;
frameShift = frameShift/1000;

t = 1/Fs : 1/Fs : (length(y)/Fs);

windowLength = frameSize*Fs;
sampleShift = frameShift*Fs;

%% Determing the Type of Window to be used
switch(windowType)
    case 'hm'
        w = hamming(windowLength);
    case 'hn'
        w = hanning(windowLength);
    otherwise
        w = hamming(windowLength);
end

%% Initializing the Variables
nWin = ( floor((length(y))/sampleShift ) - ceil(windowLength/sampleShift) );
sum = 0;
zerocrossing = zeros(1,nWin);
count = 1;

%% Implementing the Logic to Calculate the Zero Crossing Rate
for i = 1 : nWin
    y(((i-1)*sampleShift)+1)=y(((i-1)*sampleShift)+1)*w(count);
    count = count + 1;
    for j = (((i-1)*sampleShift)+2):(((i-1)*sampleShift)+windowLength)
        y(j) = y(j)*w(count);
        count = count + 1;
        yy = y(j)*y(j-1);
        if(yy < 0)
            sum = sum + 1;
        end
    end
    zerocrossing(i) = sum/(2*windowLength);
    sum = 0;
    count = 1;
end

%% Reinitialization
w = 0;

%% Returing the final required output
c = zerocrossing;