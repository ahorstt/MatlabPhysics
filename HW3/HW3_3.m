for N = 1:300 %iterate over size of n
tic%start timer
Nx = N; Ny = N;
dx = 1; dy = 1;
sL1x = 1/dx^2*(spdiags(-2*ones(Nx,1),0,sparse(Nx,Nx))+spdiags(ones(Nx,1),1,sparse(Nx,Nx))+spdiags(ones(Nx,1),-1,sparse(Nx,Nx)));
sL1y = 1/dy^2*(spdiags(-2*ones(Ny,1),0,sparse(Ny,Ny))+spdiags(ones(Ny,1),1,sparse(Ny,Ny))+spdiags(ones(Ny,1),-1,sparse(Ny,Ny))); %laplacian operators for x and y
sL2 = kron(speye(Ny),sL1x)+kron(sL1y,speye(Nx)); %kroneker products to get operator
B = zeros(Nx,Ny);
B(round(Nx/2),round(Ny/2))=1;%boundary conditions
Y = sL2\reshape(-B,Nx*Ny,1); %z values
t(N) = toc;%store time
end
figure
plot(t)
%It scales like N^2 
