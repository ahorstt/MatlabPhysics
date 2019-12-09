clear all
% PARAMETERS:
L = 5; % Interval Length
N = 400; % No of points
N2 = N/10;
x = linspace(-L,L,N)'; % Coordinate vector
dx = x(2) - x(1); % Coordinate step
i = 1;
for wid = 1:.1:3
    w = L/10;
    a = w*wid;
    Width(i) = a;
    % Two finite square wells of width 2w and distance 2a apart
    
    U = -10*(1/(2*w))*(heaviside(x+w-a) - heaviside(x-w-a) + heaviside(x+w+a) - heaviside(x-w+a));

    % storing non-zero matrix elements
    e = ones(N,1); Lap = spdiags([e -2*e e],[-1 0 1],N,N)/dx^2;
    % Total Hamiltonian
    hbar = 2; m = 1; % constants for Hamiltonian
    H = -1/2*(hbar^2/m)*Lap + spdiags(U,0,N,N);
    % Find lowest nmodes eigenvectors and eigenvalues of sparse matrix
    nmodes = 2; options.disp = 0;
    [V,E] = eigs(H,nmodes,'sa',options); % find eigs
    Ene(i) = E(1);
    Ene2(i) = E(4);
    i = i+1;
end
plot(Width,Ene/16); % plot V(x) and rescaled U(x)
hold on;
plot(Width,Ene2/16)
title('Double Well Low E Splitting');
xlabel('Barrier Width [nm]');
ylabel('Lowest Energy Eigenvalues');
hold off;
