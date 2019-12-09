clear all

c = 299792458; % m/s
h = 6.626 * 10^-34/(2*pi); % m^2 kg/s
m_e = 9.109 * 10^-31; % kg
eV = 1.602 * 10^-19; % kg m^2 /s^2
L = 0.5 * 10^-9; % m
ke = 8.987 * 10^9;
Nx = 500;

econst = 1.44 * 10^-9 * eV; %nm eV from slides

dX = L/Nx;
xs = linspace(dX, L, Nx);
La=(diag(-2*ones(Nx,1))+diag(ones(Nx-1,1),-1)+diag(ones(Nx-1,1),1)); % d^2/dr^2
La = La/dX^2;
Uscf = zeros(1, Nx);
radOp = -h^2/(2*m_e)*La-2*econst*diag(1./xs); % radial operator with l = 0. 

for i = 1:10
    Op = radOp + diag(Uscf); % radial operator
    [F,d] = eig(Op); %eigenvalues/vectors
    d(1,1)/eV; %lowest eigen energy
    sig = F(:,1) .* F(:,1); % lowest ground state and the sigma value. 
    chgEncl = zeros(1,Nx); % integral values of charge enclosed from 0 to r
    chgExcl = zeros(1,Nx); % integral values of charge excluded from r to inf
    for ii = 1:Nx
        E = 0;
        if ii ~= 1
            E = chgEncl(ii - 1);
        end
        chgEncl(ii) = E+dX*sig(ii)*4*pi* xs(ii)^2; % discrete sum
    end
    for ii = Nx:-1:1
        prevEx = 0;
        if ii ~= Nx
           prevEx = chgExcl(ii+1);
        end
        chgExcl(ii) = prevEx+dX*sig(ii)*4*pi*xs(ii); % discrete sum
    end
    Uscf = 2*10^32*econst*chgEncl./xs+econst*chgExcl; % new value
    hold on;
    plot(xs*10^9, sig);
    title('Q2 Hartree');
    xlabel('Distance (nm)');
    ylabel('\psi*\psi (nm^{-1})');
end
hold off;