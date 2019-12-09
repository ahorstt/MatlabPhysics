%these errors are not on the order I expect, mostly around 0-1.
%The functions look fine to me, I get numbers to the right order,
%but the resulting error is too large
clearvars
rand
d2 = 2; %number of dimensions
n2 = logspace(0,8,10);
Zn2 = 0;
j2=0;
for k2 = n2
    for i2 = 1:k2
        x12 = rand; %need an x for each dimension
        x22 = rand;
        R2 = sqrt(x12.^2 + x22.^2); %calculate distance from origin
        if R2 <= 1%count number of points in hypersphere
            Zn2 = Zn2+1;
        end
    end
    Zn2;
    V2 = (2^d2).*(Zn2/k2); %calculate volume
    V2T = pi; %True volume of 2d Sphere
    err2= abs(V2-V2T);
    j2 = j2+1;
    E2(j2) = err2;
    
end

rand
d4 = 4; %number of dimensions
n4 = logspace(0,8,10);
Zn4 = 0;
j4=0;
for k4 = n4
    for i4 = 1:k4
        x14 = rand; %need an x for each dimension
        x24 = rand;
        x34 = rand;
        x44 = rand;
        R4 = sqrt(x14.^2 + x24.^2 + x34.^2 + x44.^2); %calculate distance from origin
        if R4 <= 1
            Zn4 = Zn4+1;
        end
    end
    Zn4;
    V4 = (2^d4).*(Zn4/k4); %calculate volume
    V4T = (pi^2)/2; %True volume of 4d Sphere
    err4= abs(V4-V4T);
    j4 = j4+1;
    E4(j4) = err4;
    
end

rand
d6 = 6; %number of dimensions
n6 = logspace(0,8,10);
Zn6 = 0;
j6=0;
for k6 = n6
    for i6 = 1:k6
        x16 = rand; %need an x for each dimension
        x26 = rand;
        x36 = rand;
        x46 = rand;
        x56 = rand;
        x66 = rand;
        R6 = sqrt(x16.^2 + x26.^2 + x36.^2 + x46.^2 + x56.^2 + x66.^2); %calculate distance from origin
        if R6 <= 1
            Zn6 = Zn6+1;
        end
    end
    Zn6;
    V6 = (2^d6).*(Zn6/k6); %calculate volume
    V6T = (pi^3)/6; %True volume of 6d Sphere
    err6= abs(V6-V6T);
    j6 = j6+1;
    E6(j6) = err6;
    
end
figure
n2 = logspace(0,8,10);
loglog(n2.^(1/d2),E2,'b');
hold on;
n4 = logspace(0,8,10);
loglog(n4.^(1/d4),E4,'g')

n6 = logspace(0,8,10);
loglog(n6.^(1/d6),E6,'r')
hold off;