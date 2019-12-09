%Problem 1 Variational Method Hydrogen Atom
Nr = 10000
r = linspace(0,3,Nr);
ao = 5.29177*10^-11; %(m) Bohr Radius

b = [13 2 0.44 0.12]; %B vector
N = length(b);
T = zeros(N);
P = zeros(N);
OL = zeros(N);


for n = 1:(N) %Creating Matricies
    for m = 1:(N)
        
        T(m,n) = 3*(b(n)*b(m)*pi^(3/2))/(b(n)+b(m))^(5/2);
        P(m,n) = -2*pi/(b(n)+b(m));
        OL(m,n) = (pi/(b(n)+b(m)))^(3/2);
    end
end

H = T + P;
[V,E] = eig(H,OL);

g = zeros(1,length(r));

for n = 1:N
    g = g+V(n,1)*exp(-b(n).*r.^2);
end

Norm = 1.07; %Normalization by hand

figure;
plot(r,(Norm^2*(g).^2))
title('Variational Method H Atom Q1')
xlabel('Radial Position [a_0]')
ylabel('|\psi|^2')


