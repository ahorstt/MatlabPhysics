clear
Nx = 50;
Ny = 50;
Ax = (diag(-2*ones(Nx,1),0)+diag(ones(Nx-1,1),1)+diag(ones(Nx-1,1),-1));
Ax(1,50) = -1;
Ay = (diag(-2*ones(Ny,1),0)+diag(ones(Ny-1,1),1)+diag(ones(Ny-1,1),-1));
Iy = eye(Ny);
Ix = eye(Nx);
L = kron(Iy,Ay)+kron(Ax,Ix);
[V,D] = eigs(L,6,'SM');
for n = 1:6
figure;
surf(reshape(V(:,n),[Nx,Ny]));
end
