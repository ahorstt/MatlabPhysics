clear
syms x
a = 0; b = 1;
c = int(exp(x),x,0,1);%definite integral for error use
n = logspace(1,5);
B = zeros(size(n));%array for sums
i=0;
for N = round(n)
h = (b - a)/N; % this is the width of each interval
x = a:h:b;
y = exp(x);
f = 0;
for k=1:N
    f = f + 0.5*((x(k+1)-x(k))*(y(k+1)+y(k)));%integral
end
i = i+1;
B(i) = abs(c-f);
end
n = logspace(1,5);
B;
figure
loglog(n,B)
xlabel('n')
ylabel('absolute error')