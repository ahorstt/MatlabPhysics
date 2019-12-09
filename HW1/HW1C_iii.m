%This code and the hypersphere code do not function properly
%this code gives the first and last values at the right error
%the other values are much higher than expected, I cannot figure out why
clear
syms x
c = int(exp(x),x,0,1);%definite integral for error use
n = logspace(1,3);
B = zeros(size(n));%array for sums
count=0;
a=0;
b=1;
for i = n % If the input provided is an anonymous function
    h = (b-a)/(i);
    p=0;
    q=0;
    for i=1:2:(i-1)%4*values
        x=a+h*i;
        p=p+exp(x);
    end
    for k=2:2:(i-1)%2*vaues
        x=a+h*k;
        q=q+exp(x);
    end
  xi = h/3*(exp(a)+exp(b)+4*p+2*q);
count=count+1
B(count) = abs(xi-c);
end
B;
n = logspace(1,3);
c
figure
loglog(n,B)
xlabel('N')
ylabel('absolute error')