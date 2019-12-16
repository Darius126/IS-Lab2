clear all; 
clc;

x=linspace(0,1,20);

func=(1+0.6*sin(2*pi*x/0.7)+0.3*sin(2*pi*x))/2;

figure(1)
plot(x,func,x,func);
title('Etalonines funkcijos grafikas');
xlabel('Iejimo vektoriaus pozicija'); 
ylabel('f(x)');


for n=1:4
    w1(n) = randn;
    b1(n) = randn;
    w2(n) = randn;
    b2(n) = randn;
    h(n,:) = zeros(1, length(x)); %pasleptas sluoksnis
    hOUT(n,:) = zeros(1, length(x));
end

OUT = zeros(1, length(x));
e = zeros(1, length(x));



for n = 1:20
    for i = 1:4
        h(i,n) = x(n)*w1(i)+b1(i);
        hOUT(i,n) = 1/(1+exp(-h(n))); %sigmoidine funkcija
    end
end

%antras sluoksnis
E = 0;
for n = 1:20
    OUT(n) = hOUT(1,n)*w2(1) + hOUT(2,n)*w2(2) + hOUT(3,n)*w2(3) + hOUT(4,n)*w2(4) + b2(1);
    e(n) = func(n) - OUT(n);
    E = E + abs(e(n));
end

l = 0.01; %mokymosi zingsnis
maxE = 0.1;

while(E>maxE)

for n = 1:20
    
    %atnaujinamas antras sluoksnis
    for i = 1:4
        w2(i) = w2(i) + l*e(n)*hOUT(i);
        b2(i) = b2(i) + l*e(n);
    end
    
    %atnaujinamas pirmas sluoksnis
    for i = 1:4
        w1(i) = w1(i) + l*e(n)*w2(i)*x(n)*exp(b1(i)+w1(i)*x(n)) / ((exp(b1(i)+w1(i)*x(n))+1)^2);
        b1(i) = b1(i) + l*e(n)*w2(i)*exp(b1(i)+w1(i)*x(n)) / ((exp(b1(i)+w1(i)*x(n))+1)^2);
    end
end  
        

    

for n = 1:20
    for i = 1:4
        h(i,n) = x(n)*w1(i)+b1(i);
        hOUT(i,n) = 1/(1+exp(-h(n)));
    end
end


E = 0;
for n = 1:20
    OUT(n) = hOUT(1,n)*w2(1) + hOUT(2,n)*w2(2) + hOUT(3,n)*w2(3) + hOUT(4,n)*w2(4) + b2(1);
    e(n) = func(n) - OUT(n);
    E = E + abs(e(n));
end

E

end



figure(2)
hold on
plot(x,func,x,OUT);
plot(x,func,x,OUT,'k');
hold off
title('Originalus signalas VS Neuron? tinklo signalas');
legend('Originalus','Neuron? tinklo');


