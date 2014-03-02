[y,Fs] = audioread('D:\AGNEL\Engineering\BE\PROJECT\Speech\Projects Programs\Project Programs 201403011928\SoundDatabase\16000\Edition.Agnel.1.wav');
% c = Cepstrum(y,length(y));
subplot(511);
t = 1/Fs:1/Fs:length(y)/Fs;
plot(t,y);

E = STE(y,Fs,50,15,'hm');
subplot(512);
plot(E,'r');

zcr = ZCR(y,Fs,20,5,'re');
subplot(513);
plot(zcr,'green');

[f,n] = STFF(y,Fs,50,5,'hm');
subplot(514);
plot(n,f);

smoothf = medfilt1(f,4);
subplot(515);
plot(n,smoothf);

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

