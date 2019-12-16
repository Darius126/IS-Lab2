clear all; 
clc;

x=linspace(0,1,20);

func=(1+0.6*sin(2*pi*x/0.7)+0.3*sin(2*pi*x))/2;

figure(1)
plot(x,func,x,func);
title('Etalonines funkcijos grafikas');
xlabel('Iejimo vektoriaus pozicija'); 
ylabel('f(x)');


for n=1:1:4
    w1(n) = randn;
    b1(n) = randn;
    w2(n) = randn;
    b2(n) = randn;
end