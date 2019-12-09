clear all

%Something is wrong with the operator. Couldn't figure out what
w=9.4486299429; %bohr
height=1*0.0367493; %hartree
energy=(0:0.01:5)*height; %hartree
m=1; 
h=1; 
trans=zeros(length(energy),1);

dtot = 7*w; % total dist
dz = 0.01*w;
N = fix(dtot/dz);

V = zeros(N,1);%matrix for indexes
V(:) = 0;
V(200:250) = height;
V(450:500) = height;
jj = 1;

fwd = (1/dz)*(spdiags(-1*ones(N,1),0,sparse(N,N))+spdiags(ones(N,1),-1,sparse(N,N)));%fwd operator
bwd = (1/dz)*(spdiags(1*ones(N,1),0,sparse(N,N))+spdiags(-ones(N,1),1,sparse(N,N)));%bwd operator

for i=1:length(energy)
    na = sqrt(2*m*energy(i)/h^2);
    nb = sqrt(2*m*(energy(i)-height)/h^2);
    kl = 1;
    kr = na*kl;
    Ene = energy(i)*speye(N); %diag(energy(1:end-1)); energy diag to add to operator
    Vz = diag(V);
    M = h^2/(2*m)*fwd*bwd;
    M(1,1) = M(2,2);
    Op = Ene + M - Vz;%final operator
    Op(1,1) = Op(1,1) + exp(kl*dz)*(h^2/(2*m*dz^2));%end values
    Op(end,end) = Op(end,end) + exp(kr*dz)*(h^2/(2*m*dz^2));
    Op(end,1) = 1;
    Op(1,end) = 1;
    s = zeros(N,1);
    s(1,1) = (1i*h^2/(2*m*dz^2))*sin(kl*dz); %sin term vector
    psi = Op\s; %b vector
    T(jj) = sin(kr*dz)/sin(kl*dz)*abs(psi(end)).^2;
    jj = jj + 1;
end
plot(energy/height,T, 'o');
axis([0 5 0 1]);
xlabel('Energy');
ylabel('Transmittance');
title('Finite Diff vs. Transfer Method');
hold on


ii = 1;
for i=1:length(energy)-1
    for jj = 1:1:4
        if mod(jj,2) == 2
            na=sqrt(2*m*energy(i)/h^2);
            ka=1; %incoming k
            nb=sqrt(2*m*(energy(i)-height)/h^2);
            kb=nb*ka;
        else
            nb=sqrt(2*m*energy(i)/h^2);
            kb=1; %incoming k
            na=sqrt(2*m*(energy(i)-height)/h^2);
            ka=na*kb;
        end
        z = 0;
        if mod(jj,2) == 0
            z = z + 0.5*w;
        else
            z = z + 2*w;
        end
        trfr1(1,1) = (.5+(nb/(2*na)))*exp(1i*(kb-ka)*z);
        trfr1(1,2) = (.5-(nb/(2*na)))*exp(-1i*(kb+ka)*z);
        trfr1(2,1) = (.5-(nb/(2*na)))*exp(1i*(kb+ka)*z);
        trfr1(2,2) = (.5+(nb/(2*na)))*exp(-1i*(kb-ka)*z);
        if jj == 1
            T = trfr1;
        else
            T = T*trfr1;
        end
    end
    ii = ii + 1;
    r = T(2,1)/T(1,1);
    R(ii) = abs(r)^2;
    Tr(ii) = 1 - R(ii);
end
plot(energy/height,Tr);
xlabel("Energy");
ylabel("Transmittance");
title("Q3");
hold off