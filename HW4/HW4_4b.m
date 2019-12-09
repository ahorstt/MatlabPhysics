clear
R=1;
Nr=50;
Nt=50;
dr = R/Nr;
rs = dr*(1:Nr);
r = diag(rs);
Dr=1/(2*dr)*(spdiags(ones(Nr,1),1,sparse(Nr,Nr))-spdiags(ones(Nr,1),-1,sparse(Nr,Nr)));
D2r=1/(dr^2)*(spdiags(-2*ones(Nr,1),0,sparse(Nr,Nr))+spdiags(ones(Nr,1),1,sparse(Nr,Nr))+spdiags(ones(Nr,1),-1,sparse(Nr,Nr)));
Lr = D2r + r\Dr;
ts = linspace(2*pi/Nt,2*pi,Nt);
Lt = (Nt/2/pi)^2*(spdiags(-2*ones(Nt,1),0,sparse(Nt,Nt))+spdiags(ones(Nt,1),1,sparse(Nt,Nt))+spdiags(ones(Nt,1),-1,sparse(Nt,Nt)));
Lt(1,Nt) = (Nt/2/pi)^2;Lt(Nt,1) = (Nt/2/pi)^2;
L2 = kron(speye(Nt),r^2)\kron(Lt,speye(Nr))+kron(speye(Nt),Lr);
[V,D] = eigs(L2,6,'SM');
for n = 1:6
figure;
[TH,RS] = meshgrid(ts,rs);
A = reshape(V(:,n),50,50);
[X,Y]=pol2cart(TH,RS);
surf(X,Y,A)
end