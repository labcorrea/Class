clc
clear all
close all

np = 100;
nc = 10;
f = @(x) x+cos(2*pi*x);
npy = 101;
x = linspace(-1,1,np);
y = linspace(-1,1,npy);
k = -nc:nc;
for j = 1:length(k)
    C = @(x) f(x).*exp(-1i*pi*x*k(j));
    fk(j) = integral(C,-1,1);
end
F = reconstruction(y,fk,k);
F = F./(2);
figure
plot(x,f(x),'--b')
hold on
plot(y,real(F),'-xr')
legend('Original','Reconstruido')


figure
subplot(2,1,1)
stem(k,abs(fk))
xlabel('Frquencia')
ylabel('Magnitude')
subplot(2,1,2)
stem(k,180*angle(fk)/pi)
xlabel('Frquencia')
ylabel('Fase [graus]')


function F = reconstruction(y,fk,k)
for x = 1:length(y)
    F(x) = 0;
    for j= 1:length(k)
        F(x) = F(x) + fk(j)*exp(1i*k(j)*y(x)*pi);
    end
end
end