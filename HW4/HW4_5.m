clear
dx=.4;
dy=.4;
dt=0.01;
L = 10;
c = 1;
Nx = L/dx;
Ny = L/dy;
Ax = (diag(-2*ones(Nx,1),0)+diag(ones(Nx-1,1),1)+diag(ones(Nx-1,1),-1));
x = (1:Nx);
y = (1:Ny);
[X,Y]=meshgrid(x,y);
y0 = exp(-((X-Nx/2).^2/2)-((Y-Ny/2).^2/2));
y1 = y0;
y2 = zeros(Nx,Ny);
%% Visualization
for f = 1:200
    for t = 1:20
        for z = 1:Nx
            y2(:,z)=((c^2*dt^2*(Ax))+2*eye(Nx))*y1(z,:)'-y0(:,z);
        end
        y0 = y1;
        y1 = y2;
    end
    surf(y2);
    zlim([-1,1])
    drawnow;
    F(f) = getframe;
end
%movieview(F)
v = VideoWriter('HW4_5.avi');
v.FrameRate = 5;
open(v);writeVideo(v,F);close(v);