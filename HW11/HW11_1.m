clear all
%doesn't work at low energy how it should, this problem is present in the
%other related problems
w=9.4486299429; %bohr
height=1*0.0367493; %hartree
energy=(0:0.01:5)*height; %hartree energies
m=1; 
h=1; 
trans=zeros(length(energy),1);
trno = [2 4 6 10 20 40]
for j = 1:length(trno)
    no = trno(j);
    ii = 1;
for i=1:length(energy)-1
    for jj = 1:1:no
        if mod(jj,2) == 2
            na=sqrt(2*m*energy(i)/h^2);
            ka=1; %incoming k
            nb=sqrt(2*m*(energy(i)-height)/h^2);
            kb=nb*ka;
        else
            nb=sqrt(2*m*energy(i)/h^2);
            kb=1; %incoming k
            na=sqrt(2*m*(energy(i)-height)/h^2);
            ka=na*kb;
        end
        z = 0;
        if jj == 1;
            z=0
        elseif mod(jj,2) == 0
            z = z + w;
        else
            z = z + 2*w;
        end
        trfr1(1,1) = (.5+(nb/(2*na)))*exp(1i*(kb-ka)*z);%Transfer Matrix
        trfr1(1,2) = (.5-(nb/(2*na)))*exp(-1i*(kb+ka)*z);
        trfr1(2,1) = (.5-(nb/(2*na)))*exp(1i*(kb+ka)*z);
        trfr1(2,2) = (.5+(nb/(2*na)))*exp(-1i*(kb-ka)*z);
        if jj == 1
            T = trfr1;
        else
            T = T*trfr1;
        end
    end
    ii = ii + 1;
    r = T(2,1)/T(1,1);
    R(ii) = abs(r)^2;
    Tr(ii) = 1 - R(ii);%Transmittance
end
figure;
hold on;
plot(energy/height,Tr);
xlabel("Energy [eV]")
ylabel("Transmittance")
title([num2str(trno(j)/2) 'Barriers'])
end
hold off