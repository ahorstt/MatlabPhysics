clear
dtot = 500*10^-9; % total dist air/film/air
d = 100*10^-9; %nm
dz = 5*10^-9;
N = fix(dtot/dz);
na = 1.00;
nb = 1.33;
n = zeros(N,1);%matrix for indexes
n(:) = nb;
n(1:(N-20)/2-1) = na;
n(N-(N-20)/2:end) = na;
e = n.^2;%matrix for e values
jj = 1;

fwd = (1/dz)*(spdiags(-1*ones(N,1),0,sparse(N,N))+spdiags(ones(N,1),-1,sparse(N,N)));%fwd operator
bwd = (1/dz)*(spdiags(1*ones(N,1),0,sparse(N,N))+spdiags(-ones(N,1),1,sparse(N,N)));%bwd operator

for L = 300:750
    lamda = L*10^-9;
    k = (2*pi*na)/lamda;
    omega = k^2*speye(N); %omega diag to add to operator
    fe = 1./e;
    eps = diag(fe);% e diag to use in operator
    M = fwd*eps*bwd;
    M(1,1) = M(2,2);
    Op = omega + M;%final operator
    Op(1,1) = Op(1,1) + exp(1i*k*dz)/dz^2;%end values
    Op(end,end) = Op(end,end) + exp(1i*k*dz)/dz^2;
    Op(end,1) = 1;
    Op(1,end) = 1;
    s = zeros(N,1);
    s(1,1) = (2*1i/dz^2)*sin(k*dz); %sin term vector
    b = Op\s; %b vector
    T = abs(b(end)).^2;
    Re(jj) = 1-T; %reflectivity
    wl(jj) = L;
    jj = jj + 1;
end
plot(wl,Re, 'o');
axis([300 800 0.05 0.08]);
xlabel('Wavelength');
ylabel('Reflectance');
title('Bubble Reflectance');
hold on

%HW6_2
%init vals
z1 = 0.01;
z2 = z1 + d;
ii = 1;

for L = 300:750
    lamda = L*10^-9;
    % transfer matrix 1
    kb = (2*pi*nb)/lamda;
    ka = (2*pi*na)/lamda;
    trfr1(1,1) = (.5+(nb/(2*na)))*exp(1i*(kb-ka)*z1);
    trfr1(1,2) = (.5-(nb/(2*na)))*exp(-1i*(kb+ka)*z1);
    trfr1(2,1) = (.5-(nb/(2*na)))*exp(1i*(kb+ka)*z1);
    trfr1(2,2) = (.5+(nb/(2*na)))*exp(-1i*(kb-ka)*z1);

    % TM 2
    trfr2(1,1) = (.5+(na/(2*nb)))*exp(1i*(ka-kb)*z2);
    trfr2(1,2) = (.5-(na/(2*nb)))*exp(-1i*(ka+kb)*z2);
    trfr2(2,1) = (.5-(na/(2*nb)))*exp(1i*(ka+kb)*z2);
    trfr2(2,2) = (.5+(na/(2*nb)))*exp(-1i*(ka-kb)*z2);

    T = trfr1*trfr2;
    r = T(2,1)/T(1,1);
    R(ii) = abs(r)^2;
    wavelength(ii) = L;
    ii = ii + 1;
end
plot(wavelength,R);
legend('Finite Diff', 'Transfer Matrix')
hold off