clear all

dz = 0.001;
L = 1;
N = L/dz;

eps(1:(0.8/dz)) = 1;
eps(((0.8/dz)+1):N) = 13;

fwd = (diag(ones((N-1),1),1)-diag(ones((N),1)))/dz;
bwd = (diag(ones((N),1))-diag(ones((N-1),1),-1))/dz;
fwd(1,1) = 0;
bwd(N,N) = 0;

%determining Kdusing periodic bounadries
k = 2*pi;

K = k*ones(1,N)
%fwd = fwd+diag(K);
%bwd = bwd+diag(K);

M = diag(K.^2./eps)-bwd\diag(eps)*fwd;

%Finding eigenvalues and solving
[V,D] =eig(M);