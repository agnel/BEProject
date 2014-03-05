[y,Fs] = audioread('Edition.Agnel.1.wav');

%% ZCR
% subplot(211);
% t = 1/Fs:1/Fs:length(y)/Fs;
% plot(t,y);
% title('Plot of Original Signal');
% xlabel('Time (sec)');
% ylabel('Amplitude');

% subplot(212);
% ZCRor = ZCR(y,Fs,20,5,'re');
% plot(ZCRor,'r');
% title('PLot of Zero Crossing Rate');
% xlabel('Frames');
% ylabel('Zero Crossing Rate');

%% STE
% subplot(211);
% t = 1/Fs:1/Fs:length(y)/Fs;
% plot(t,y);
% title('Plot of Original Signal');
% xlabel('Time (sec)');
% ylabel('Amplitude');

% subplot(212);
% Eor = STE(y,Fs,50,15,'hm');
% plot(Eor,'r');
% title('Plot of Short Time Energy');
% xlabel('Frames');
% ylabel('Energy');

%% STE with Threshold
% subplot(211);
% t = 1/Fs:1/Fs:length(y)/Fs;
% plot(t,y);
% title('Plot of Original Signal');
% xlabel('Time (sec)');
% ylabel('Amplitude');

% E = medfilt1(Eor, 5); E = medfilt1(E, 5); % apply median filter twice on original signal
% E_mean = mean(E);
% Weight = 3;
% [HistE, X_E] = hist(E, round(length(E) / 10));  % histogram computation
% [MaximaE, countMaximaE] = findMaxima(HistE, 3); % find the local maxima of the histogram
% if (size(MaximaE,2)>=2) % if at least two local maxima have been found in the histogram:
%     T_E = (Weight*X_E(MaximaE(1,1))+X_E(MaximaE(1,2))) / (Weight+1); % ... then compute the threshold as the weighted average between the two first histogram's local maxima.
% else
%     T_E = E_mean / 2;
% end

% hold on;
% plot(E, 'b');
% legend({'Short time energy (original)', 'Short time energy (filtered)'});
% L = line([0 length(E)],[T_E T_E]);
% set(L,'Color',[0 0 0]);
% set(L, 'LineWidth', 2);
% axis([0 length(Eor) min(Eor) max(Eor)]);

%% Pitch Contour Using Cepstrum
% subplot(211);
% t = 1/Fs:1/Fs:length(y)/Fs;
% plot(t,y);
% title('Plot of Original Signal');
% xlabel('Time (sec)');
% ylabel('Amplitude');

% subplot(212);
% [f,n] = STFF(y,Fs,50,15,'hm');
% subplot(514);
% plot(n,f);
% title('Fundamental Frequency Contour');
% xlabel('Frames');
% ylabel('F0');

%% Pitch Contour using yaapt
% subplot(211);
% t = 1/Fs:1/Fs:length(y)/Fs;
% plot(t,y);
% title('Plot of Original Signal');
% xlabel('Time (sec)');
% ylabel('Amplitude');

% subplot(212);
% ExtraParam.f0_min = 50;
% ExtraParam.f0_max = 500;
% ExtraParam.frame_length = 25;
% ExtraParam.frame_space = 10;
% [Pitch,nframes,framerate] = yaapt(y,Fs,1,ExtraParam,0);
% plot(1:nframes,Pitch);
% title('Fundamental Frequency Contour');
% xlabel('Frames');
% ylabel('F0');

%% Mapped ZCR
% subplot(211);
% t = 1/Fs:1/Fs:length(y)/Fs;
% plot(t,y);
% title('Plot of Mapping of ZCR on Original Signal');
% xlabel('Time (sec)');
% ylabel('Amplitude');
% 
% hold on;
% 
% ZCRor = ZCR(y,Fs,20,5,'re');
% ZCRmapped = getMapped(ZCRor,y);
% plot(t,ZCRmapped,'r');
% legend({'Original Speech Signal','ZCR Mapped'});

%% Mapped STE
% subplot(211);
% t = 1/Fs:1/Fs:length(y)/Fs;
% plot(t,y);
% title('Plot of Mapping of STE on Original Signal');
% xlabel('Time (sec)');
% ylabel('Amplitude');
% 
% hold on;
% 
% Eor = STE(y,Fs,50,15,'hm');
% Emapped = getMapped(Eor,y);
% plot(t,Emapped),'r';
% legend({'Original Speech Signal','STE Mapped'});

%% Mapped F0
% subplot(211);
% t = 1/Fs:1/Fs:length(y)/Fs;
% plot(t,y);
% title('Plot of Mapping of F0 on Original Signal');
% xlabel('Time (sec)');
% ylabel('Amplitude');
% 
% hold on;
% 
% ExtraParam.f0_min = 50;
% ExtraParam.f0_max = 500;
% ExtraParam.frame_length = 25;
% ExtraParam.frame_space = 10;
% [Pitch,nframes,framerate] = yaapt(y,Fs,1,ExtraParam,0);
% Pitchnor = Pitch/(max(Pitch));
% Pitchmapped = getMapped(Pitchnor,y);
% plot(t,Pitchmapped);
% axis([0 max(t) min(y)-0.5 max(Pitchmapped)+0.2]);