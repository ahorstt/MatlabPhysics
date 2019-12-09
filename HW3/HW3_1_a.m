clear
X = 0:20;
Y = 0:20;

for i = 1:21
    Nx = 21;
    Ny = 21;
    M = zeros(Nx,Ny);
    M(1,:) = -1;%Boundary Conditions
    M(:,1) = -1;
    M(Nx,:) = 1;
    M(:,Ny) = 1;
    A = 1/4*(diag(ones(Nx-1,1),1)+diag(ones(Nx-1,1),-1));%Operator for next matrix
    dev = 1;
    count = 1;
    while dev > 1e-6 %loop until max variation threshold is below 1e-6
        count = count + 1;
        prev(1) = .5;
        prev(count) = M(2,7);
        M = A*M + M*A'; %iterate on matrix M using A
        M(1,:) = -1; %Restate boundary conditions
        M(:,1) = -1;
        M(Nx,:) = 1;
        M(:,Ny) = 1;
        dev(count) = abs(prev(count-1)-M(2,7));
    end
end

figure
surf(X,Y,M)

    