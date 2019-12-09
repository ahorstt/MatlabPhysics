clear
N=2^12;             % Number of sample points. 
L=0.66e-5;           % Wavelength (red light). 
D=500e-5;          % Total x distance sampled (1mm). 
W=5e-6;            % Slit width (20um). 
d = 3*W
dx=D/N;                 % The x-domain sample interval (approx).
dq = 1/D;
dtheta=L*dq;            % Angular displacement interval. 
x=zeros(1,N);           % Construct x vector proportional to the field amplitude. 
W2=(W/2/dx);
x(N/2-W2 : N/2+W2)=1; % Set field strength constant over the slit width. 
xf=dx*fftshift(fft(x));     % FFT scaled and shifted - Transform domain is q = theta/lambda). 
subplot(2,1,1) 
plot([-N/2:N/2-1]*dx,abs(x).^2)   % Plot the x-domain intensity (converting to per mm). 
xlabel('Slit Position (mm)') 
ylabel('Intensity') 
title ('Slit') 
subplot(212) 
plot([-N/2 : N/2-1]*dtheta,abs(xf).^2/L)    % Plot q-domain intensity (converting to per radian). 
xlabel('Angular Position (radians)') 
ylabel('Intensity') 