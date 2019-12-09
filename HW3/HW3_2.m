clear

for N = 1:300%loop over N
    Nx = N;
    Ny = N;
    M = zeros(Nx,Ny);
    M(1,:) = -1;
    M(:,1) = -1;
    M(Nx,:) = 1;
    M(:,Ny) = 1;
    A = 1/4*(diag(ones(Nx-1,1),1)+diag(ones(Nx-1,1),-1));
    dev = 1;
    tic;%start timer
    count = 1;
    while dev > 1e-6
        count = count + 1;
        prev = M(1,1);
        M = A*M + M*A';
        M(1,:) = -1;
        M(:,1) = -1;
        M(Nx,:) = 1;
        M(:,Ny) = 1;
        dev = abs(prev-M(1,1));
    end
    t(N) = toc; %store time for each iteration
end

figure
plot(t)%Scaling dependent on r^2