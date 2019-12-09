clear all;
D = 1; 
dx = 0.1; 
Nx = 100; 
P = []; %parameter values
v = -2;
for tau = [0.1,0.25,0.5,1]
%d2/dx2 operator
dx2=1/dx^2*(spdiags(-2*ones(Nx,1),0,sparse(Nx,Nx))+spdiags(ones(Nx,1),1,sparse(Nx,Nx))+spdiags(ones(Nx,1),-1,sparse(Nx,Nx)));
dx2(1,1) = -1/dx^2; dx2(end,end) = -1/dx^2; 

%d/dx operator
dx1 = spdiags(-1*ones(Nx,1),0,sparse(Nx,Nx))+spdiags(ones(Nx,1),-1,sparse(Nx,Nx));
dx1(end,end) = 0;

%1/tau on diagonals matrix
sLdecay = (1/tau)*speye(Nx);

%drift,diffusion,and -1/tau on diagonals operator
drift = D*dx2 - (v/dx)*dx1 - sLdecay; 
M = zeros(Nx,1); 
M(Nx/2,1) = -1;
F = drift\M
plot(F)
hold on
end
hold off
xlabel('position')
ylabel('density')
title('1fiii')
legend('Tau=0.1','Tau=0.25','Tau=0.5','Tau=1')

