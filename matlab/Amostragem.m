close all
clear all
clc

fm = 2*pi*10; % bandwidth of baseband signal
fs = 20; % Hz number of samples or Sampling Freq
Sig = @(t) 1.2*sin(fm*t);
t=linspace(0,1,1000);


figure
subplot(3,1,1)
plot(t,Sig(t))
Axx=[0 1 1.2*min(Sig(t)) 1.2*max(Sig(t))];
axis(Axx);ylabel('g(t)');xlabel('\itt (sec)');grid on;
title(sprintf('Baseband Signal (f_m=%gHz)',fm))

sam = ones(1,fs);
t_s = linspace(0,1,fs);

subplot(3,1,2)
stem(t_s,sam,'filled','MarkerSize',5)
axis([0 1 -0.2 1.2]);ylabel('s(t)');xlabel('\itt (sec)');
title(sprintf('Sampling Signal (f_s=%gHz)',fs))

subplot(3,1,3)
stem(t_s,Sig(t_s),'filled','MarkerSize',5)
axis(Axx);ylabel('g_s(t)');xlabel('\itt (sec)');title('Sampled Signal')

%%
syms t
Sig1 = 1.2*sin(fm*t);
figure
subplot(3,1,1)
Fsig = fourier(Sig1);
fplot(real(Fsig))
xlim([-1 1]*10)
ylim([-1 1]*2)

fwin = rectangularPulse(0,1,t);
Fwin = fourier(fwin);
subplot(2,1,2)
fplot(real(Fwin))
xlim([-1 1]*100)
ylim([-1 1])

f = fwin*Sig1;
F = fourier(f);
%subplot(3,1,3)
%fplot(real(F))
%xlim([-1 1]*100)
%ylim([-1 1])

%%
figure
subplot(3,1,1)
fplot(real(Sig1))
subplot(3,1,2)
fplot(real(fwin))
subplot(3,1,3)
fplot(real(f))
