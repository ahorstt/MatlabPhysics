
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

Vr = logspace(-3,1,30)
g1 = [];
g2 = [];
g3 = [];

for z = 1:length(Vr)
    Vnot = Vr(z)
    Vm = [Vnot/2,Vnot,Vnot/2]
    E_fin = [];
    k_fin = [];
    %Finding the k vs energy plot
    dens = 0.001;
    kd = [0,pi];
    for d = 1:length(kd)
        k = kd(d);
        for a = 1:N
            for b = 1:N
                if a == b
                    H(a,b) = (hb)^2/(2*me)*(k+G(a))^2+Vm(2);
                elseif abs(a-b) == 1
                    H(a,b) = Vnot/2;
                    
                else
                    H(a,b) = 0;
                end
            end
        end
        [V,D] = eig(H);
        lim = 5;
        E_now = diag(D(1:lim,1:lim));
        if k == 0;
            g1(end+1) = (D(3,3)-D(2,2))
        end
        if k == pi
            g2(end+1) = (D(2,2)-D(1,1))
            g3(end+1) = (D(4,4)-D(3,3))
        end
    end
end

figure
loglog(Vr,g1,'r')
hold on
loglog(Vr,g2,'g')
loglog(Vr,g3,'b')
xlabel("Vnot")
ylabel("gap")
title("Q5")
hold off