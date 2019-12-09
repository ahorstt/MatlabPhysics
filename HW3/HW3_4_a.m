clear
%{
This code does not work correctly (and therefore for parts b & c as well, 
which i still added the boundary conditions to), I believe the operators 
are all set upcorrently, and the boundary conditions are added on the 
appropirate matricies, as well as before and after using the final operator 
on the matrix. I think either the final operator (sL2) is incorrect, or I'm
implementing the laplacians incorrectly. I get a graph that clearly only
has the boundary conditions.
%}
Nt = 100; Nr = 100;
dt = 1; dr = 1;
sL1t = 1/dt^2*(spdiags(-2*ones(Nt,1),0,sparse(Nt,Nt))+spdiags(ones(Nt,1),1,sparse(Nt,Nt))+spdiags(ones(Nt,1),-1,sparse(Nt,Nt)));
sL1t(Nt,1) = 1;
sL1t(1,Nt) = 1;
sL1r = 1/dr^2*(spdiags(-2*ones(Nr,1),0,sparse(Nr,Nr))+spdiags(ones(Nr,1),1,sparse(Nr,Nr))+spdiags(ones(Nr,1),-1,sparse(Nr,Nr)));
sL1r(1,1) = -1;
sL2r = 1/(2.*dr)*(spdiags(ones(Nr,1),1,sparse(Nr,Nr))+spdiags((-1)*ones(Nr,1),-1,sparse(Nr,Nr)));
sL2r(1,1) = -2;
sL2r(1,2) = 2;
rs=linspace(0,1,Nr);
sL2 = kron(sL1r,speye(Nt))+kron(sL2r\(diag(rs)),speye(Nt))+kron((diag(1\rs.^2)),speye(Nt))*kron(speye(Nr),sL1t);
B = zeros(Nt,Nr);
B(1,:) = 1;
z = sL2\reshape(-B,Nt*Nr,1);
Z = reshape(z,Nr,Nt);
Z(1,:) = 1;
Z(Nr,:) = 0;
ths=linspace(0,2*pi,Nt);
[Nth,Nr] = meshgrid(ths,rs);
[X,Y] = pol2cart(Nth,Nr);
figure
surf(X,Y,Z)