clear
%init vals
na = 1.00;
nb = 1.33;
d = 100*10^-9; %nm
z1 = 0.01;
z2 = z1 + d;
ii = 1;

for L = 300:750
    lamda = L*10^-9;
    % transfer matrix 1
    kb = (2*pi*nb)/lamda;
    ka = (2*pi*na)/lamda;
    trfr1(1,1) = (.5+(nb/(2*na)))*exp(1i*(kb-ka)*z1);
    trfr1(1,2) = (.5-(nb/(2*na)))*exp(-1i*(kb+ka)*z1);
    trfr1(2,1) = (.5-(nb/(2*na)))*exp(1i*(kb+ka)*z1);
    trfr1(2,2) = (.5+(nb/(2*na)))*exp(-1i*(kb-ka)*z1);

    % TM 2
    trfr2(1,1) = (.5+(na/(2*nb)))*exp(1i*(ka-kb)*z2);
    trfr2(1,2) = (.5-(na/(2*nb)))*exp(-1i*(ka+kb)*z2);
    trfr2(2,1) = (.5-(na/(2*nb)))*exp(1i*(ka+kb)*z2);
    trfr2(2,2) = (.5+(na/(2*nb)))*exp(-1i*(ka-kb)*z2);

    T = trfr1*trfr2;
    r = T(2,1)/T(1,1);
    R(ii) = abs(r)^2;
    wavelength(ii) = L;
    ii = ii + 1;
end
plot(wavelength,R);
axis([300 800 0.05 0.08]);
xlabel('Wavelength');
ylabel('Reflectance');
title('Bubble Reflectance TM Q2');