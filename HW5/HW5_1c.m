mxS = 1e4;
wlk = 5;
ang = 2*pi*rand(mxS,wlk);
poX = cumsum([zeros(1,wlk);cos(ang)]);
poY = cumsum([zeros(1,wlk);sin(ang)]);
plot(poX,poY)
axis equal
title('1c')
ylabel('y');
xlabel('x');