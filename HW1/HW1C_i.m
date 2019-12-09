clear
h = logspace(-10,0,15);

for i = 1:15
    f(i) = abs(((exp(h(i))-1)/h(i))-1);
    c(i) = abs(((exp(h(i))-exp(-h(i)))/(2*h(i)))-1);
end
figure
loglog(h,f,'g')
hold on;
loglog(h,c,'b')
hold off;
xlabel('h')
ylabel('absolute error in d/dx exp(x)')