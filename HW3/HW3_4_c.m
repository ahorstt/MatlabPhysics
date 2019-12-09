clear
Nt = 30; Nr = 30;
dth = 2*pi/Nt; dra = 1/Nr;
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
z = sL2\reshape(-B,Nt*Nr,1);
Z = reshape(z,Nr,Nt);
Z(1,20) = 1;
for n = 1:3%Boundary Conditions
    for t = 1:Nt
Z(Nr,:) = sin(n.*t*dth);
    end
end
ths=linspace(0,2*pi,Nt);
[Nth,Nr] = meshgrid(ths,rs);
[X,Y] = pol2cart(Nth,Nr);
figure
surf(X,Y,Z)