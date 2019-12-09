x = -4e-08:10e-10:4e-08;
y=1-cos(x);
y2=2*sin(x/2).^2;
figure
plot(x,y,x,y2)

x2 = -1e-15:1e-17:1e-15;
y3 = exp(x2)-1;
y4 = expm1(x2);
figure
plot(x2,y3,x2,y4)
xlabel('x')


