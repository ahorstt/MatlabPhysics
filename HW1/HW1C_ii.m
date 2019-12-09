clear
y = logspace(-10,0,15);

for i = 1:15
    d(i) = abs((exp(y(i))-2*exp(0)+exp(-y(i)))/(y(i).^2));
end
figure
loglog(y,abs(d-1))
axis([1e-10 1e0 1e-9 1e0])
xlabel('h')
ylabel('absolute error in d^2/dx^2')
