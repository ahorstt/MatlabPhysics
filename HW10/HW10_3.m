clear all

c = 299792458; % m/s
h = 6.626 * 10^-34/2/pi; % m^2 kg/s
m_e = 9.109 * 10^-31; % kg
eV = 1.602 * 10^-19; % kg m^2 /s^2
e0 = 8.854*10^(-12); %C^2/Nm^2
a0 = (5.29177*10^(-11)); %bohr radius of helium
e2k = 1.44 * 10^-9 * eV; %(1.44 nm eV)


%variables for problem
T = 300; %k -temp
u = 0; %eV
ms = 0.25*m_e; %kg - apparent mass
er = 4;
kb = 1.380*10^(-23); 
b = 1/(kb*T);

Wth = 9*10^(-9); %nm - well width
Dpt = 3*eV; %eV - well potential depth
eVg = 0.25*eV; %gate depth

%Init Potential
N = 1000;
a = ((Wth/(2)));
x = linspace((-(2*a)),(2*a),N);
U = -3*eV*(heaviside(x+a)-heaviside(x-a))+3*eV;
Upb = zeros(1,N);
Upb(1,250) = 0.25*eV;
Upb(1,751) = 0.25*eV;
U = (U+Upb); %perturbed potential with linear gate purturbation

%Solving schodinger eq
loopct = 0;
loopstat = true;
e_dold = 0;
Eold = 0;

while loopstat == true
    
    loopct = loopct+1;
    
    %Schrodinger Eq
    H = -h^2/(2*m_e*(4*a/(N-1))^2).*spdiags(repmat([1 -2 1],N,1),[-1 0 1],sparse(N,N))+spdiags(U',0,sparse(N,N));

    nmodes = 10 ; options.disp = 0;
    [V,Es] = eigs(H,nmodes,'sa',options);
    %Density
    dty_trk = zeros(N,1);
    for n = 1:length(Es)
        if sum(isnan(Es(:,n)))<1
            f = 2*ms/(pi*b*h^2)*log(1+exp(-b*(Es(n,n))));
            phi2 = abs(V(:,n)).^2;
            dty_trk = dty_trk+(f.*phi2);
        end
    end
    ed = 2.*dty_trk;
    if sum(ed)==0
        ed = e_dold;
    end
    
    F = length(ed);
    
    dx = x(2)-x(1);
    d1 = (diag(ones(N,1))-diag(ones(N-1,1),-1))/dx;
    d1f = (diag(ones(N-1,1),1)-diag(ones(N,1)))/dx;
    
    M_p = d1*diag(1./(er*ones(1,N)))*d1f;%Poisson Potential
    
    %M_p = diag(-2*ones(F,1),0)+diag(ones(F-1,1),1)+diag(ones(F-1,1),-1);
    Uneu = -(ed)\M_p;
    
    alpha = 0.2;
    U = U+alpha*(Uneu-U);
    
    %comparing
    if loopct == 1
        loopstat = false;
    end
    
end

%Finding final density
H = -h^2/(2*m_e*(4*a/(N-1))^2).*spdiags(repmat([1 -2 1],N,1),[-1 0 1],sparse(N,N))+spdiags(U',0,sparse(N,N));

nmodes = 10 ; options.disp = 0;
[V,Es] = eigs(H,nmodes,'sa',options);
%finding density by summing over states
dty_trk = zeros(N,1);
for n = 1:length(Es)
    if sum(isnan(Es(:,n)))<1
        f = 2*ms/(pi*b*h^2)*log(1+exp(-b*(Es(n,n))));
        phi2 = abs(V(:,n)).^2;
        dty_trk = dty_trk+(f.*phi2);
    end
end
ed = 2.*dty_trk;

figure
plot(x,ed)
hold on
figure
plot(x,U)

clear all
% Single Interface

%Constants
c = 299792458; % m/s
h = 6.626 * 10^-34/2/pi; % m^2 kg/s
m_e = 9.109 * 10^-31; % kg
eV = 1.602 * 10^-19; % kg m^2 /s^2
e0 = 8.854*10^(-12); %C^2/Nm^2
a0 = (5.29177*10^(-11)); %bohr radius of helium
e2k = 1.44 * 10^-9 * eV; %(1.44 nm eV)


%Given Values
T = 300; %k -temp
u = 0; %eV
ms = 0.25*m_e; %kg - apparent mass
er = 4;
kb = 1.380*10^(-23); 
b = 1/(kb*T);

Wth = 9*10^(-9); %nm - well width
Dpt = 3*eV; %eV - well potential depth
eVg = 0.25*eV; %gate depth

%init Potential
N = 1000;
a = ((Wth/(2)));
x = linspace((-(2*a)),(2*a),N);
U = 3*eV*heaviside(x-a);
Upb = zeros(1,N);
Upb(1,751) = 0.50*eV;
U = (U+Upb); %perturbed potential with linear gate purturbation

%Solving schodinger equation for above potential
%taking from previous hw and solutions
loopct = 0;
loopstat = true;
Eold = 0;
e_dold = 0;
while loopstat == true
    
    loopct = loopct+1;
    
    %Schrodinger Eq
    H = -h^2/(2*m_e*(4*a/(N-1))^2).*spdiags(repmat([1 -2 1],N,1),[-1 0 1],sparse(N,N))+spdiags(U',0,sparse(N,N));

    nmodes = 10 ; options.disp = 0;
    [V,Es] = eigs(H,nmodes,'sa',options);
    %finding density by summing over states
    dty_trk = zeros(N,1);
    for n = 1:length(Es)
        if sum(isnan(Es(:,n)))<1
            f = 2*ms/(pi*b*h^2)*log(1+exp(-b*(Es(n,n))));
            phi2 = abs(V(:,n)).^2;
            dty_trk = dty_trk+(f.*phi2);
        end
    end
    ed = 2.*dty_trk;
    if sum(ed)==0
        ed = e_dold;
    end
    
    F = length(ed);
    %Poisson potential
    M_p = diag(-2*ones(F,1),0)+diag(ones(F-1,1),1)+diag(ones(F-1,1),-1);
    Uneu = -(ed)\M_p;
    
    alpha = 0.2;
    U = U+alpha*(Uneu-U);
    
    %comparing
    if loopct == 9
        loopstat = false;
    end
end

%Finding final density
H = -h^2/(2*m_e*(4*a/(N-1))^2).*spdiags(repmat([1 -2 1],N,1),[-1 0 1],sparse(N,N))+spdiags(U',0,sparse(N,N));

nmodes = 10 ; options.disp = 0;
[V,Es] = eigs(H,nmodes,'sa',options);
%finding density by summing over states
dty_trk = zeros(N,1);
for n = 1:length(Es)
    if sum(isnan(Es(:,n)))<1
        f = 2*ms/(pi*b*h^2)*log(1+exp(-b*(Es(n,n))));
        phi2 = abs(V(:,n)).^2;
        dty_trk = dty_trk+(f.*phi2);
    end
end
ed = 2.*dty_trk;


figure
plot(x,ed)
hold on
figure
plot(x,U)