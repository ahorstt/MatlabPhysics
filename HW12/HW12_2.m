clear all
%init Constants
hbar = 1;
m = 1;
N = 256;
eV = (10^16)/6.582;
meter = sqrt(.511/9)*10^-5*sqrt(eV);
x = linspace(-2,2,N)*meter*10^-9;
dx = x(2) - x(1);
om = eV;

V = 1/2*m*om^2*x.^2;
%% HW12 Question 2 a
%ground state
phi0=((m*om/(pi*hbar))^(1/4)*exp(-m*om*x.^2/(2*hbar)));
phi0 = phi0/norm(phi0);

t = (0.01:0.01:20);
dt = 10^(-17);
q=1;
for n = 1:length(t)
    T = ([0:N/2 -N/2+1:-1]*2*pi/(x(end)-x(1))).^2*hbar^2/(2*m);  
    expV = exp(-1i.*V.*dt/(2*hbar));
    expT = exp(-1i.*T.*dt/hbar);
    expV2 = exp(-1i.*V.*dt/(2*hbar));
    phi =  expV.*ifft((expT.*fft(expV2.*phi0)));
    if mod(n,10)==0
        Fin(q,:) = (phi0);
        q = q+1;
    end
    phi0 = phi;
end
figure;
imagesc([-2 2], [0 20], conj(Fin).*(Fin));
title('Question 2a')
xlabel('Position [nm]')
ylabel('Time (fs)')
colormap('jet')
%% HW12 Q2b
%ground state (1/sr2(p0+p1))
phinot=((m*om/(pi*hbar))^(1/4)*exp(-m*om*x.^2/(2*hbar)));
phinot = phinot/norm(phinot);
phi1 = sqrt(2*m*om/hbar).*x.*((m*om/(pi*hbar))^(1/4)*exp(-m*om*x.^2/(2*hbar)));
phi1 = phi1/norm(phi1);
phi0 = 1/sqrt(2)*(phinot+phi1);

t = (0.01:0.01:20);
dt = 10^(-17);
q=1;
for n = 1:length(t)
    T = ([0:N/2 -N/2+1:-1]*2*pi/(x(end)-x(1))).^2*hbar^2/(2*m);  
    expV = exp(-1i.*V.*dt/(2*hbar));
    expT = exp(-1i.*T.*dt/hbar);
    expV2 = exp(-1i.*V.*dt/(2*hbar));
    phi =  expV.*ifft((expT.*fft(expV2.*phi0)));
    if mod(n,10)==0
        Fin(q,:) = (phi0);
        q = q+1;
    end
    phi0 = phi;
end
figure;
imagesc([-2 2], [0 20], conj(Fin).*(Fin));
title('Question 2b')
xlabel('Position [nm]')
ylabel('Time (fs)')
colormap('jet');
%% HW12 Q2c
phi0=((m*om/(pi*hbar))^(1/4)*exp(-m*om*x.^2/(2*hbar)));
phi0 = phi0/norm(phi0);

t = (0.01:0.01:20);
dt = 10^(-17);
q=1;
for n = 1:length(t)
    T = ([0:N/2 -N/2+1:-1]*2*pi/(x(end)-x(1))).^2*hbar^2/(2*m);
    %Add Energy to potential
    if n == 1
        %A is wrong but I don't know how to alter it in my units.
        V = (1/2*m*om^2*x.^2+(10*eV*meter)*conj(phi0).*phi0);
    else
        V = 1/2*m*om^2*x.^2;
    end
    expV = exp(-1i.*V.*dt/(2*hbar));
    expT = exp(-1i.*T.*dt/hbar);
    expV2 = exp(-1i.*V.*dt/(2*hbar));
    phi =  expV.*ifft((expT.*fft(expV2.*phi0)));
    if mod(n,10)==0
        Fin(q,:) = (phi0);
        q = q+1;
    end
    phi0 = phi;
end
figure;
imagesc([-2 2], [0 20], conj(Fin).*(Fin));
title('Question 2c')
xlabel('Position [nm]')
ylabel('Time (fs)')
colormap('jet');
%% HW12 Q2d
%ground state
phi0=((m*om/(pi*hbar))^(1/4)*exp(-m*om*x.^2/(2*hbar)));
phi0 = phi0/norm(phi0);

t = (0.01:0.01:20);
dt = 10^(-17);
q=1;
for n = 1:length(t)
    T = ([0:N/2 -N/2+1:-1]*2*pi/(x(end)-x(1))).^2*hbar^2/(2*m);
    %Add Energy to potential
    if n == 300
        V = (V+(5*eV)/(meter*10^-9).*x);
    end
    expV = exp(-1i.*V.*dt/(2*hbar));
    expT = exp(-1i.*T.*dt/hbar);
    expV2 = exp(-1i.*V.*dt/(2*hbar));
    phi =  expV.*ifft((expT.*fft(expV2.*phi0)));
    if mod(n,10)==0 & n~=300
        Fin(q,:) = (phi0);
        q = q+1;
    end
    phi0 = phi;
end
figure;
imagesc([-2 2], [0 20], conj(Fin).*(Fin));
title('Question 2d')
xlabel('Position [nm]')
ylabel('Time (fs)')
colormap('jet');