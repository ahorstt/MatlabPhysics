N=2^10;                 % Number of sample points. 
L=0.6e-4;              % Wavelength (red light). 
D=1000e-5;               % Total x distance sampled (1mm). 
W=5e-5;                % Slit width (20um). 
d = 6*W;
dx=D/N;                 % The x-domain sample interval (approx).
dq = 1/D;               
dtheta=L*dq;            % Angular displacement interval. 
x=zeros(1,N);           % Construct x vector proportional to the field amplitude. 
W2=(W/2/dx);
d2 = (d/2/dx);
n=10;
for i = -n:n
    x(N/2-W2+i*d2 : N/2+W2+i*d2)=1; % Set field strength constant over the slit width. 
end
xf=dx*fftshift(fft(x));     % FFT scaled and shifted - Transform domain is q = theta/lambda). 
plot([-N/2 : N/2-1]*dtheta,abs(xf).^2/L)    % Plot q-domain intensity (converting to per radian). 
xlabel('Angular Position (radians)') 
ylabel('Intensity') 

%{
Adding a dielectric to one of the slits would impart a phase shift on one
of the waves coming out of that slit. When the waves interfere normally,
the biggest point of intensity is at the middle, since they interfere
constructively at this point, where the symmetric waves add. If one is
phaseshifted, the waves would interfere at different places, so i would
expect a shift in the overall pattern from side to side. 
%}