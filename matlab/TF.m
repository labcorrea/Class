syms t
f = exp(-(t+5)^2);
%f = (sin(2*pi*t)/(2*pi*t))^2;
F=fourier(f)

figure
subplot(4,1,1)
fplot(f)
subplot(4,1,2)
fplot(real(F))
subplot(4,1,3)
fplot(imag(F))
subplot(4,1,4)
fplot((angle(F)))