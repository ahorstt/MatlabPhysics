%Question 3
clear all


hbar =1.05457*10^(-34);
eV = 1.602*10^(-19); %J - 1 electron volt (eV)
w = eV/hbar; %wavelength*2pi
m = 9.109*10^(-31); %kg
x = [-49.99:0.01:50].*10^(-9);
t = [0.1:0.1:100].*10^(-15);
x0 = -20*10^(-9); %nm 
s0 = 1*10^(-9); %nm
k = 5/(1*10^(-9));
dt = t(2)-t(1);

sv = 1*10^(-9); %nm 
V0 = (1*eV*exp(-x.^2./(2*sv^2)));
Phi0 = exp(-(x-x0).^2./(2*s0^2)).*exp(1i*k*x);

clear Y_3
for n = 1:length(t)
    N = length(x);
    T = ([0:N/2 -N/2+1:-1]*2*pi/(x(end)-x(1))).^2*hbar^2/(2*m);
    expV = (exp(-1i.*V0.*dt/hbar/2));
    expT = (exp(-1i.*T.*dt/hbar));
    Phi0 = ((expV.*ifft(expT.*fft(expV.*Phi0))));
    Fin(n,:) = Phi0;
   
end
figure;
imagesc([x(1),x(end)],[t(1),t(end)],conj(Fin).*(Fin))
title('Question 3a')
xlabel('Position [m]')
ylabel('Time (s)')
colormap('Jet')
%% 3b

sv = 0.1*10^(-9);
xv = 5*10^(-9);
V0 = (1.5*eV*(exp(-x.^2./(2*sv^2))+exp(-(x-xv).^2./(2*sv^2))));
Phi0 = exp(-(x-x0).^2./(2*s0^2)).*exp(1i*k*x);


clear Y_3
for n = 1:length(t)
    N = length(x);
    T = ([0:N/2 -N/2+1:-1]*2*pi/(x(end)-x(1))).^2*hbar^2/(2*m);
    expV = (exp(-1i.*V0.*dt/hbar/2));
    expT = (exp(-1i.*T.*dt/hbar));
    Phi0 = ((expV.*ifft(expT.*fft(expV.*Phi0))));
    Fin(n,:) = Phi0;
   
end
figure;
imagesc([x(1),x(end)],[t(1),t(end)],conj(Fin).*(Fin))
title('Question 3b')
xlabel('Position [m]')
ylabel('Time (s)')
colormap('Jet')