%% Hw 12 Question 1 Graphene Band Structure
clear all
clf;		

E0 = 0; % coloumb integral
V = -2.7; % hopping integral [eV]
cc = 1.8; % c-c bond length [Angstrom]
lattice = cc*sqrt(3); % Lattice constant
% Creating necessary k-vectors
kx = linspace(-2*pi/lattice,2*pi/lattice,100);
ky = linspace(-2*pi/lattice,2*pi/lattice,100);
[kmx,kmy] = meshgrid(kx, ky);
% Energy values with the preset parameters
energy = NaN([size(kmx,1),size(kmy,2),2]);
for n = 1 : size(kmx,1)
    energy(:,n,1) = (E0 + V*sqrt(1 + ...
        (4.*((cos(kmy(:,n)/2*lattice)).^2)) + ...
        (4.*(cos(sqrt(3)/2*lattice*kmx(:,n))).*...
        (cos(kmy(:,n)/2*lattice)))));

    energy(:,n,2) = (E0 - V*sqrt(1 + ...
        (4.*((cos(kmy(:,n)/2*lattice)).^2)) + ...
        (4.*(cos(sqrt(3)/2*lattice*kmx(:,n))).*...
        (cos(kmy(:,n)/2*lattice)))));

end
% Plotting
surf(kmx, kmy, real(energy(:,:,1)));
hold on
surf(kmx, kmy, real(energy(:,:,2)));
colormap('jet');
shading interp
title('Question1 3d');
xlabel('k_x');
ylabel('k_y');
zlabel('E(k)');
axis([-1.5 1.5 -1.5 1.5]);
hold off
figure;
contour(kmx, kmy, real(energy(:,:,1)));
title('Question1 2d');
xlabel('k_x');
ylabel('k_y');
axis([-1.5 1.5 -1.5 1.5]);

%%Linear Plot
