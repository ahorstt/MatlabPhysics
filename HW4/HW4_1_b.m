clear;

%% Set problem
dt=0.00725;   % time step
dx=0.01;    % spatial resolution
c = 1;
L = 10;
N = L/dx;
y0 = 0;
y1 = 5e-3*exp((-((1:N)'-(N/2)).^2)/10000);
%% Solve wave equation using nuerical method
A = (1/(dx.^2))*(diag(-2*ones(N,1),0)+diag(ones(N-1,1),1)+diag(ones(N-1,1),-1));
I = eye(N);
x = ((1:N)*dx);
%% Visualization
for f = 1:200
    for t = 1:20
        y2 = ((c^2)*(dt.^2)*A+2*I)*y1-y0;
        y0 = y1;
        y1 = y2;
    end
    plot(x,y2);
    axis([0 10 -1 1]);
    drawnow;
    F(f) = getframe;
end
%movieview(F)
v = VideoWriter('HW4_1_b.avi');
v.FrameRate = 5;
open(v);writeVideo(v,F);close(v);