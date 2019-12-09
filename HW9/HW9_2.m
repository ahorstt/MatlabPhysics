clear all
% PARAMETERS:
L = 5; % Interval Length
N = 1000; % No of points
x = linspace(-L,L,N)'; % Coordinate vector
dx = x(2) - x(1); % Coordinate step

% Finite square well of width 2w and depth given
i = 1;
for wid = 10:5:100
    w = L/wid;
    Width(i) = 2*w;
    U = -(1/(2*w))*100*(heaviside(x+w)-heaviside(x-w));
    % storing non-zero matrix elements
    e = ones(N,1); Lap = spdiags([e -2*e e],[-1 0 1],N,N)/dx^2;
    % Total Hamiltonian
    hbar = 1; m = 1; % constants for Hamiltonian
    H = -1/2*(hbar^2/m)*Lap + spdiags(U,0,N,N);
    % Find lowest nmodes eigenvectors and eigenvalues of sparse matrix
    nmodes = 1; options.disp = 0;
    [V,E] = eigs(H,nmodes,'sa',options); % find eigs
    Ene(i) = E(1)
    i = i+1;
end
plot(Width,Ene./100,'o'); % plot V(x) and rescaled U(x)
title('Finite Well \alpha = 1eVnm');
xlabel('Well Width [nm]');
ylabel('Ground State Energy [eV]');