clear all
clc
[y,Fs] = audioread('Edition.Agnel.1.wav');
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

[f,n] = STFF(y,Fs,50,15,'hm');
subplot(514);
plot(n,f);

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

smoothf = medfilt1(f,5);
smoothf = medfilt1(f,5);
subplot(515);
plot(n,smoothf);

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

