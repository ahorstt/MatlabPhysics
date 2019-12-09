clear
X = 0:20;
Y = 0:20;

for i = 1:21
    Nx = 21;
    Ny = 21;
    M = zeros(Nx,Ny);
    M(10,10) = 1; %Boundary Condition
    A = 1/4*(diag(ones(Nx-1,1),1)+diag(ones(Nx-1,1),-1));
    dev = 1;
    count = 1;
    while dev > 1e-6
        count = count + 1;
        prev(1) = .5;
        prev(count) = M(11,10);
        M = A*M + M*A';
        M(10,10)= 1;
        dev = abs(prev(count-1)-M(11,10));
    end
end

figure
surf(X,Y,M)