
clear all
V0 = 0.5; %eV - amplitude of potential
N = 7;
a = 1;
x =(1:N).*(a/N); 
k = pi/a;
hb = 6.5821995*10^(-16); %hbar from plancks constant
me = 9.10938356*10^(-31); %mass of electron

%Constructing subscript matrix m
hm = (N-1)/2;
for n = 1:hm
    m(n) = -(hm-n+1);
end
m(end+1) = 0;
for n = 1:hm
    m(end+1) = (n);
end

%Constructing G matrix
G = (2*pi/a).*m;

%finding potential
V = V0*cos(2*pi*x/a);
Vm = [V0/2,V0,V0/2];

%constructing matrix
H = zeros(N);
m_wrap = [m,m,m,m];
m_num = [1:N,1:N,1:N];

for a = 1:N
    for b = 1:N
        if a == b
            H(a,b) = (hb)^2/(2*me)*(k+G(a))^2+Vm(2);
        elseif abs(a-b) == 1
            H(a,b) = V0/2;
            
        else
            H(a,b) = 0;
        end
    end
end
[V,D] = eig(H);
%Constructing U(x)
xs = linspace(0,1,100);
for n = 1:length(V);
    psi(n,:) = zeros(1,length(xs));
    for g = 1:length(V)
        psi(n,:) = psi(n,:)+V(n,g)*exp(i*G(g).*xs);
    end
end

figure
plot(xs,abs(psi(2,:)).^2)
hold on
plot(xs,real(psi(5,:)),'g')
xlabel('Pos [a]')
ylabel('|\psi|^2')
title('Q4')
plot(xs,0.5*cos(2*pi*xs)+0.7,'k')
legend('Mode 1','Mode 2','Potential')

E_fin = [];
k_fin = [];
%Finding the k vs energy plot 
dens = 0.001;
kd = -3.1:dens:3.1;
for d = 1:length(kd)
    k = kd(d);
    for a = 1:N
        for b = 1:N
            if a == b
                H(a,b) = (hb)^2/(2*me)*(k+G(a))^2+Vm(2);
            elseif abs(a-b) == 1
                H(a,b) = V0/2;

            else
                H(a,b) = 0;
            end
        end
    end
    [V,D] = eig(H);
    lim = 5;
    E_now = diag(D(1:lim,1:lim));
    for u = 1:length(E_now)
        E_fin(end+1) = E_now(u)*0.076;
        k_fin(end+1) = k/kd(end);
    end
end

figure
plot(k_fin,2*E_fin,'.')
title('Q4 k space')
xlabel('k[pi/a]')
ylabel('Energy (eV)')
ylim([-1,7])