clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
p = zeros(1,1e4);
p2 = zeros(1,1e4);
p3 = zeros(1,1e4);

for n = 1:1e4
r = 2*randi(2, 1, 1e2)- 3;
x(1) = 0;
for i = 2 : length(r)
	x(i) = x(i-1) + r(i);
end
    p(n) = x(end);
end
for n = 1:1e4
r = 2*randi(2, 1, 1e3)- 3;
x(1) = 0;
for i = 2 : length(r)
	x(i) = x(i-1) + r(i);
end
    p2(n) = x(end);
end
for n = 1:1e4
r = 2*randi(2, 1, 1e4)- 3;
x(1) = 0;
for i = 2 : length(r)
	x(i) = x(i-1) + r(i);
end
    p3(n) = x(end);
end
x(end)
figure;
histogram(p,39,'DisplayStyle','stairs');
hold on;
histogram(p2,120,'DisplayStyle','stairs');
histogram(p3,190,'DisplayStyle','stairs');
hold off;
axis([-300 300 0 800])
legend('1e2','1e3','1e4')
% Enlarge figure to full screen.
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
grid on;
title('1a');
ylabel('Density');
xlabel('Position');