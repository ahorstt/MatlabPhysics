%I think my operator might be incorrect on this one. It doesn't seem to
%allow the modes to venture outside the slab.
clear;
a = 300;
k = pi/a;
ea = 1;
e = 11.4;
thick = a;
L = 1000;
dx = 1;
Na = a/dx;
N = L/dx;

b = dx:dx:L;

E(1:L/dx) = ea;
E((N-Na)/2:(N+Na)/2) = e;

fwd = (diag(ones(N-1,1),1)-diag(ones(N,1)))/dx;
fwd(1,1)=0;
bwd = (diag(ones(N,1))-diag(ones(N-1,1),-1))/dx;
bwd(N,N) = 0;

M = diag(E)*k^2 - bwd*(diag(E)*fwd);%operator
M2 = diag(E)*k^2 - fwd*(diag(E)*bwd);
G = (M+M2)/2;
[V,D] = eig(G);%Get eigenVals/Modes

x = linspace(0,100,1000)
for i = [1,2,5]
plot(x,10*(V(:,i).^2));
hold on
end
plot(x,(E-1)/200);
hold off
axis([0 100 0 0.07])
xlabel('Position')
title('Dielectric Slab Modes')
%figure;
%x = sqrt(abs(diag(D)))*(a/(2*pi));

