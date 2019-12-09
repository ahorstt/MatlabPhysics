clear
nt = 30;
nx = 101;
alpha = 1; % diffusivity
L = 10;
tmax = 10;
dx = L/(nx-1);
dt = tmax/(nt-1);
d2 = -diag(ones(nx,1))+diag(ones(nx-1,1),1); d2=(d2+d2');
d2(1,1:2)=[-1 1]; d2(nx,(nx-1):nx)=[1 -1]; %insulating bc
d2 = d2/(dx^2);
d1 = (diag(ones(nx,1))-diag(ones(nx-1,1),-1))/dx;
d1(nx,nx) = 0;

D=1;
v=1;
H = D*d2-v*d1;

x = linspace(dx,L,nx);
U = zeros(nx,nt);

gauss = (exp(-(x-(2.5)).^2));
U(:,1) = gauss;
I = eye(nx);
Y = zeros(nx);
for i = 1:nt
   U(:,i+1) = (((I+(dt*D*H/2))/(I-(dt*D*H/2))))*U(:,i);
   plot(x,abs(U(:,i)))
   axis([0 10 0 2])
   hold on
end
hold off
title('Drift Diffusion Gauss Q1')
xlabel('distance')
ylabel('density')
