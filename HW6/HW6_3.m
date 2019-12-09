clear
%init vals
z = 0;
ii = 1;
T=[];
d = [97.33; 48.60; 761.47; 412.85; 720.06; 382.28; 705.03; 370.42;...
    709.26; 358.23; 718.52; 353.08; 724.86; 360.01; 710.47; 398.52; 564.95;...
    40.79; 224.72; 125.31; 133.58; 98.28; 268.21; 138.25; 238.01; 125.48; ...
    232.65; 68.54; 168.55; 150.14; 254.28; 125.25; 307.19; 165.16; ...
    256.22; 133.04; 289.60; 147.63; 266.04; 134.34; 265.60; 156.86; ...
    294.15; 123.17; 250.12; 178.96; 528.64; 0.]
a = flipud(d)
for L = 3000:6000
    lamda = L*10^-9;
    for jj = 1:length(a)
        if jj == 1
            na = 1.00;
            nb = 2.2;
        elseif mod(jj,2) == 0
            na = 2.2;
            nb = 4.2;
        else
            na = 4.2;
            nb = 2.2;
        end
        z = z + a(jj)*10^-9;
        % transfer matrix 1
        kb = (2*pi*nb)/lamda;
        ka = (2*pi*na)/lamda;
        trfr1(1,1) = (.5+(nb/(2*na)))*exp(1i*(kb-ka)*z);
        trfr1(1,2) = (.5-(nb/(2*na)))*exp(-1i*(kb+ka)*z);
        trfr1(2,1) = (.5-(nb/(2*na)))*exp(1i*(kb+ka)*z);
        trfr1(2,2) = (.5+(nb/(2*na)))*exp(-1i*(kb-ka)*z);
        if jj == 1
            T = trfr1;
        else
            T = T*trfr1;
        end
        jj = jj + 1;
    end
    t = 1/T(1,1);
    I(ii) = 4.2*abs(t)^2;
    wavelength(ii) = L;
    ii = ii + 1;
end
plot(wavelength,I)
axis([2000 7000 0 1]);
xlabel('Wavelength');
ylabel('Transmittance');
title('Stack Transmittnce TM Q3');