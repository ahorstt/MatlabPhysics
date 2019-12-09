clear
Nt = 80; Nr = 80;
dth = 2*pi/80; dra = 1/80;
dt = 1; dr = 1;
sL1t = 1/dt^2*spdiags(-2*ones(Nt,1),0,sparse(Nt,Nt))+spdiags(ones(Nt,1),1,sparse(Nt,Nt))+spdiags(ones(Nt,1),-1,sparse(Nt,Nt));
sL1r = 1/dr^2*spdiags(-2*ones(Nr,1),0,sparse(Nr,Nr))+spdiags(ones(Nr,1),1,sparse(Nr,Nr))+spdiags(ones(Nr,1),-1,sparse(Nr,Nr));
sL2 = kron(speye(Nr),sL1t)+kron(sL1r,speye(Nt));
B = zeros(Nt,Nr);
B(:,Nt) = 0;
B(:,1) = 1;
Y = sL2\reshape(-B,Nt*Nr,1);
R = reshape(Y,Nr,Nt);
Nth = 1:80;
Nra = 1:80;
figure
surf((dra.*(Nra)).*cos(dth.*Nth),(dra.*(Nra)).*sin(dth.*Nth),R);