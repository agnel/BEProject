function [c] = STE(speechSignal, Fs, frameSize, frameShift, windowType)
%	Name: STE
%   Description: Function to plot speech wave form and compute short time energy
%   Tags: Short time Energy, STE, Short-time Energy
%   INPUTS:
%	@param	type: @array		speechSignal: The Actual Speech signal
%	@param	type: @integer		Fs: Sampling Rate of speech signal
%	@param	type: @integer		frameSize: Window size(in milliseconds)
%	@param	type: @integer		frameShift: Window Overlapping(in milliseconds)
%	@param	type: @string		windowType: type of window used. 're' for Rectangular, 'hm' for Hamming, 'hn' for Hanning
%   OUTPUTS:
%   @param  type: @vector       c: Short Time Energy
%   Author: Agnel Waghela.
%   Version: 2.1
%   Date: 2nd March, 2014
%   Dependencies: None

%% Storing the Arguments
y = speechSignal;

frameSize = frameSize/1000;
frameShift = frameShift/1000;

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
energy = zeros(1,nWin);
count = 1;

%% Implementing the Logic to Calculate the Short Time Energy
for i = 1 : nWin
   
   for j = ( ( (i-1)*sampleShift ) + 1 ):( ( (i-1)*sampleShift ) + windowLength )
       y(j) = y(j)*w(count);
       count = count + 1;
       ySq = y(j)*y(j);
       sum = sum + ySq;
   end
   
   energy(i) = sum;
   sum=0;
   count=1;
end

%% Returing the final required output
c = energy;