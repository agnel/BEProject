clear all
clc
%% Plot the Original Signal
[y,Fs] = audioread('Edition.Agnel.1.wav');
figure; % 1st Figure
subplot(311);
t = 1/Fs:1/Fs:length(y)/Fs;
plot(t,y);

%% Plot the Short Time Energy with Threshold
Eor = STE(y,Fs,50,15,'hm');

% Get and plot the Dynamically calculated threshold
E = medfilt1(Eor, 5); E = medfilt1(E, 5); % apply median filter twice on original signal
E_mean = mean(E);
Weight = 3;
[HistE, X_E] = hist(E, round(length(E) / 10));  % histogram computation
[MaximaE, countMaximaE] = findMaxima(HistE, 3); % find the local maxima of the histogram
if (size(MaximaE,2)>=2) % if at least two local maxima have been found in the histogram:
    T_E = (Weight*X_E(MaximaE(1,1))+X_E(MaximaE(1,2))) / (Weight+1); % ... then compute the threshold as the weighted average between the two first histogram's local maxima.
else
    T_E = E_mean / 2;
end

% % Thresholding:
% Flags1 = (E>=T_E);

subplot(312);
plot(Eor, 'r');
hold on;
plot(E, 'b');
legend({'Short time energy (original)', 'Short time energy (filtered)'});
L = line([0 length(E)],[T_E T_E]);
set(L,'Color',[0 0 0]);
set(L, 'LineWidth', 2);
axis([0 length(Eor) min(Eor) max(Eor)]);

%% Plot Short time Zero Crossing Rate
zcror = ZCR(y,Fs,20,5,'re');
subplot(313);
plot(zcror,'r');

hold on;

Weight = 1;

zcr = medfilt1(zcror, 5); zcr = medfilt1(zcr, 5);
[HistZCR, X_ZCR] = hist(zcr, round(length(zcr) / 10));
[MaximaZCR, countMaximaZCR] = findMaxima(HistZCR, 3); % find the local maxima of the histogram
if (size(MaximaZCR,2)>=2) % if at least two local maxima have been found in the histogram:
    T_ZCR = (Weight*X_ZCR(MaximaZCR(1,1))+X_ZCR(MaximaZCR(1,2))) / (Weight+1); % ... then compute the threshold as the weighted average between the two first histogram's local maxima.
else
    T_ZCR = E_mean / 2;
end

plot(zcr, 'b');
legend({'Short time zcr (original)', 'Short time zcr (filtered)'});
L = line([0 length(zcr)],[T_ZCR T_ZCR]);
set(L,'Color',[0 0 0]);
set(L, 'LineWidth', 2);
axis([0 length(zcror) min(zcror) max(zcror)]);


%% Plot the Original and map ZCR on it

figure; % 2nd Figure
subplot(311);
t = 1/Fs:1/Fs:length(y)/Fs;
plot(t,y);

hold on;

ZCRmapped = getMapped(zcr,y);
plot(t,ZCRmapped,'r');

hold off;

%% Plot the Original and map STE on it

subplot(312);
t = 1/Fs:1/Fs:length(y)/Fs;
plot(t,y);

hold on;

STEmapped = getMapped(Eor,y);
plot(t,STEmapped,'r');

% [f,n] = STFF(y,Fs,50,15,'hm');
% subplot(514);
% plot(n,f);

% i = 2; thres=0;
% smoothf = zeros(1,length(f));
% % while ( pos < n )
% for pos = 2:length(f)-1
%     prev = f(pos-1);
%     curr = f(pos);
%     next = f(pos+1);
%     if( abs(prev-curr)>=thres || abs(next-curr)>=thres )
%         if( prev~=0 && next~=0 )
%             smoothf(pos) = (prev+next)/2;
%         else
%             smoothf(pos) = 0;
%         end
%     end
% %     pos = pos + 1;
% end
% 
% subplot(515);
% plot(n,smoothf);

% smoothf = medfilt1(f,5);
% smoothf = medfilt1(f,5);
% subplot(515);
% plot(n,smoothf);

% ZCR by poonam sharma
% sgny = zeros(length(y),1);
% for i=1:length(y)
%     if(y(i)>=0)
%         sgny(i)=1;
%     else
%         sgny(i)=-1;
%     end
% end
% subplot(211);
% plot(y);
% subplot(212)
% plot(sgny);

