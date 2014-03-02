function [F0,n] = STFF(speechSignal, Fs, frameSize, frameShift, windowType)
%	Name: STFF
%   Description: Function to compute short time Fundamental Frequency;
%   Tags: Short time Fundamental Frequency, Fundamental Frequency, Short-time Fundamental Frequency
%   INPUTS:
%	@param	type: @vector		speechSignal:   The Actual Speech signal
%	@param	type: @integer		Fs:             Sampling Rate of speech signal
%	@param	type: @integer		frameSize:      Window size(in milliseconds)
%	@param	type: @integer		frameShift:     Window Overlapping(in milliseconds)
%	@param	type: @string		windowType:     type of window used. 're' for Rectangular, 'hm' for Hamming, 'hn' for Hanning
%   OUTPUTS:
%   @param  type: @vector       F0:              Fundamental Frequencies for each frame
%   @param  type: @vector       n:           Number of Windows in a speech signal including overlapped windows
%   Author: Agnel Waghela.
%   Version: 1.2
%   Date: 1st March, 2014
%   Dependencies: Cepstrum.m PitchDetection.m

%% Storing the Arguments
y = speechSignal;

%% Convert to milliseconds (ms)
frameSize = frameSize/1000;
frameShift = frameShift/1000;

%% Determine the time scale
t = 1/Fs : 1/Fs : (length(y)/Fs);

%% Convert ms to points
windowLength = round( frameSize*Fs );
sampleShift = round( frameShift*Fs );

%% Creating a set of Time values corresponding to Amplitude values
tySet=[t' y];

%% Total Number of Windows including Overlapping
nWin = ( floor((length(y))/sampleShift ) - ceil(windowLength/sampleShift) );
n = 1:nWin;

%% Initializing the Variables
F0 = zeros(1,nWin);
yFramed = zeros(windowLength,1);
% tFramed = zeros(windowLength,1);
ceptSet = zeros(windowLength,nWin);
% tcepMaxPos = 0;
% pitchFreq = 0;

%% Implementing the Logic to Calculate the Short Time Energy
for i = 1 : nWin
    
%     tFramed = tySet( ( ( (i-1)*sampleShift ) + 1 ):( ( (i-1)*sampleShift ) + windowLength ), 1 );
    yFramed = tySet( ( ( (i-1)*sampleShift ) + 1 ):( ( (i-1)*sampleShift ) + windowLength ), 2 );
    
    cepSet(:,i) = Cepstrum(yFramed, windowType);
    pitchFreq = PitchDetection(cepSet(:,i),Fs);
    F0(i) = pitchFreq;

end