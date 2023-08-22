fs = 1000;
t = (0:1/fs:1.5)';
x = cos(2*pi*t*200);
figure
wvd(x,fs)

x = x + vco(cos(2*pi*t),[250 450],fs);
xt = timetable(seconds(t),x);
figure
wvd(xt)

figure
fs = 1000;
t = 0:1/fs:1;

x = chirp(t,100,1,400,'quadratic') + chirp(t,350,1,50);

wvd(x,fs)