D = 1; 
dx = 1e-7; 
Nx = 100; 
P = [];  
tau = 1e-9; %parameter values
v = 10^3
%d2/dx2 operator
sLdx2=1/dx^2*(spdiags(-2*ones(Nx,1),0,sparse(Nx,Nx))+spdiags(ones(Nx,1),1,sparse(Nx,Nx))+spdiags(ones(Nx,1),-1,sparse(Nx,Nx)));
sLdx2(1,1) = -1/dx^2; 
sLdx2(end,end) = -1/dx^2; 

%d/dx operator
sLdx1 = spdiags(-1*ones(Nx,1),0,sparse(Nx,Nx))+spdiags(ones(Nx,1),-1,sparse(Nx,Nx));
sLdx1(end,end) = 0;

%1/tau on diagonals matrix
sLdecay = (1/tau)*speye(Nx);

%drift,diffusion,and -1/tau on diagonals operator
sLD = D*sLdx2 - (v/dx)*sLdx1 - sLdecay; 
sL = [sLD sLdecay; sLdecay sLD]; %full matrix operator 
sL = [ones(1,2*Nx); sL]; %add conservation of particle number
M = zeros(2*Nx,1); 
M = [(2*Nx);M]; %RHS of matrix equation
Y = (sL\M); %solution by left division
n_up = Y(1:Nx); 
n_down = Y(Nx+1:end); %spin up and spin down vectors
P = (n_up - n_down)./(n_up+n_down); %construct polarization vector
X = dx*(-Nx/2:Nx/2-1)
plot(X,P,'o')
xlabel('position')
ylabel('density')
title('1fi')
legend('V=0.1','V=0.5','V=1')