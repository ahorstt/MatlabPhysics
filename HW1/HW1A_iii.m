x3 = 1e-1:15:100;
a = 1;
c = 1;
y3 = (-x3 + sqrt(x3.^2-4*a*c))/2*a; %quadratic formula
z3 = (2*c./(-x3-sqrt(x3.^2-4*a*c))); %solution tranform (true value)
er =abs(z3-y3); %error
figure
semilogx(a*c./x3.^2,er);
xlabel('ac/b^2')
ylabel('relative error')