close all
clear all
clc
%%
fs = 8e3;
myVoice = audiorecorder(fs,24,1);
% Define callbacks to show when
% recording starts and completes.
myVoice.StartFcn = 'disp(''Start speaking.'')';
myVoice.StopFcn = 'disp(''End of recording.'')';
 
record(myVoice, 5);
%To listen to the recording, call the play method:
 
%play(myVoice)
%%
data = myVoice.getaudiodata;
data(end/2:end) = [];
%%
figure
subplot(5,1,1:4)
[s,f,t]=spectrogram(data,128,120,128,fs);
surf(t,f,abs(s))
view(2)
shading flat
colormap jet

subplot(5,1,5)
plot(data)



%figure
%wvd(data(35000:40000),fs)
