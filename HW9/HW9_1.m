% PARAMETERS:
L = 5; % Interval Length
N = 1000;
x = linspace(-L,L,N)'; % Coordinate vector
dx = x(2) - x(1); % Coordinate step
for ii = 1:4
    if ii == 1
        % POTENTIAL
        U = 1/2*100*x.^(2); % quadratic harmonic oscillator potential
    end
    if ii == 2
        %Finite Sq Well
        w = L/20;
        U = -100*(heaviside(x+w)-heaviside(x-w));
    end
    if ii == 3
        %Double Well width w, spacing a
        w = L/20; a=4*w;
        U = -100*(heaviside(x+w-a) - heaviside(x-w-a) ...
         + heaviside(x+w+a) - heaviside(x-w+a));
    end
    if ii == 4
        %Exponential Well
        U = -100*exp(-abs(x)/1);
    end
    e = ones(N,1); Lap = spdiags([e -2*e e],[-1 0 1],N,N)/dx^2;
    % Total Hamiltonian
    hbar = 1; m = 1; % constants for Hamiltonian
    H = -1/2*(hbar^2/m)*Lap + spdiags(U,0,N,N);
    % Find lowest nmodes eigenvectors and eigenvalues of sparse matrix
    nmodes = 10; options.disp = 0;
    [V,E] = eigs(H,nmodes,'sa',options); % find eigs
    [E,ind] = sort(diag(E));% convert E to vector and sort low to high
    V = V(:,ind); % rearrange corresponding eigenvectors
    % Generate plot of lowest energy eigenvectors V(x) and U(x)
    Usc = U*max(abs(V(:)))/max(abs(U)); % rescale U for plotting
    figure;
    subplot(2,1,1);
    plot(x,10*(abs(V(:,1:2)).^2),x,Usc,'--k'); % plot V(x) and rescaled U(x)
    xlabel('Position')
    ylabel('|\psi(x)|^2')
    if ii == 2
        axis([-2 2 -0.4 0.4]);
        title('Finite QW');
    elseif ii == 3
        axis([-3 3 -0.2 0.2]);
        title('Double Well');
    elseif ii == 1
        axis([-2 2 -0.3 0.3]);
        title('Harmonic Oscillator');
    else
        axis([-2 2 -0.3 0.3]);
        title('Exponential Well');
    end
    subplot(2,1,2);
    plot(E,'o');
    xlabel('Quantum Number')
    ylabel('Energy')
end