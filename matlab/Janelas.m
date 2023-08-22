close all
clear all
clc
%%
fa = 4e6;
fc = 250e3;

t = 0:1/fa:0.000111;
t = 0:1/fa:0.0001;

y = sin(fc*2*pi*t);

figure(1)
subplot(2,1,1)
plot(t,y)
%%
pad = numel(t);
pad = 2048;
w = linspace(0,fa,pad);
Y = fft(y,pad);
subplot(2,1,2)
plot(w,abs(Y))
xlim([0 fa/2])
%%
N = numel(t);

% janela retangular
figure(2)
plot(t,y)
hold all

% janela triangular
triWin = triang(N)';
ytri = triWin.*y;
Ytri = fft(ytri,pad);
plot(t,ytri)

% janela hann
hannWin = hann(N)';
yhann =  hannWin.*y;
Yhann = fft(yhann,pad);

plot(t,yhann)

% janela Hamming
hammWin = hamming(N)';
yhamm =  hammWin.*y;
Yhamm = fft(yhamm,pad);

plot(t,yhamm)

% janela nuttal
nuttWin = nuttallwin(N)';
ynutt =  nuttWin.*y;
Ynutt = fft(ynutt,pad);

plot(t,ynutt)

% janela blackman
blackWin = blackman(N)';
yblack =  blackWin.*y;
Yblack = fft(yblack,pad);

plot(t,yblack)

% janela flattopwin
flatWin =flattopwin(N)';
yflat =  flatWin.*y;
Yflat = fft(yflat,pad);

plot(t,yflat)

% janela gausswin
gaussWin =gausswin(N,0.1)';
ygauss =  gaussWin.*y;
Ygauss = fft(ygauss,pad);

plot(t,ygauss)

% janela tukeywin
tukeykWin =tukeywin(N,0.1)';
ytukey =  tukeykWin.*y;
Ytukey = fft(ytukey,pad);

plot(t,ytukey)

%%

figure(3)
plot(w,abs(Y))
hold all
plot(w,abs(Ytri))
plot(w,abs(Yhann))
plot(w,abs(Yhamm))
plot(w,abs(Ynutt))
plot(w,abs(Yblack))
plot(w,abs(Yflat))
plot(w,abs(Ygauss))
plot(w,abs(Ytukey))

%%
figure(4)
plot(w,20*log10(abs(Y)))
hold all
plot(w,20*log10(abs(Ytri)))
plot(w,20*log10(abs(Yhann)))
plot(w,20*log10(abs(Yhamm)))
plot(w,20*log10(abs(Ynutt)))
plot(w,20*log10(abs(Yblack)))
plot(w,20*log10(abs(Yflat)))
plot(w,20*log10(abs(Ygauss)))
plot(w,20*log10(abs(Ytukey)))
