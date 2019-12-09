mxS = 100;
wlk = 1e3;
ang = 2*pi*rand(mxS,wlk);
poX = cumsum([zeros(1,wlk);cos(ang)]);
poY = cumsum([zeros(1,wlk);sin(ang)]);
x = poX(end,:);
y = poY(end,:);

mxS2 = 1000;
wlk2 = 1e3;
ang2 = 2*pi*rand(mxS2,wlk2);
poX2 = cumsum([zeros(1,wlk2);cos(ang2)]);
poY2 = cumsum([zeros(1,wlk2);sin(ang2)]);
x2 = poX2(end,:);
y2 = poY2(end,:);

figure;
scatter(x2,y2,'o','blue')
hold on;
scatter(x,y,'o','red')
hold off;
axis equal
title('1d')
ylabel('y');
xlabel('x');