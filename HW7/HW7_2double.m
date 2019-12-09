N=2^12;             % Number of sample points. 
L=0.66e-5;           % Wavelength (red light). 
D=500e-5;          % Total x distance sampled (1mm). 
W=5e-6;            % Slit width (20um). 
d = 3*W;
dx=D/N;
dq = 1/D;% The x-domain sample interval (approx).
dtheta=L*dq;            % Angular displacement interval. 
x=zeros(1,N);           % Construct x vector proportional to the field amplitude. 
W2=(W/2/dx);
d2 = (d/2/dx)
x(N/2-W2+d2 : N/2+W2+d2)=1; % Set field strength constant over the slit width. 
x(N/2-W2-d2 : N/2+W2-d2)=1; % Set field strength constant over the slit width. 
xf=dx*fftshift(fft(x));     % FFT scaled and shifted - Transform domain is q = theta/lambda). 
plot([-N/2 : N/2-1]*dtheta,abs(xf).^2/L)    % Plot q-domain intensity (converting to per radian). 
xlabel('Angular Position (radians)') 
ylabel('Intensity') 
title('Double slit')