M = 360*rand(32);

count = 1;
J = 0.4;

N = 10^5;
for n = 1:N
    x = randi(32); %random i position
    y = randi(32); %random j position

    %Calculating total energy from nearest neightboors
    if x == 32
        M_R = cosd(M(x,y)-M(1,y));
    else
        M_R = cosd(M(x,y)-M(x+1,y));
    end
    if y == 32
        M_D = cosd(M(x,y)-M(x,1));
    else
        M_D = cosd(M(x,y)-M(x,y+1));
    end
    if y == 1
        M_U = cosd(M(x,y)-M(x,32));
    else
        M_U = cosd(M(x,y)-M(x,y-1));
    end
    if x == 1
        M_L = cosd(M(x,y)-M(32,y));
    else
        M_L = cosd(M(x,y)-M(x-1,y));
    end
    E = -1*J*(M_L+M_right+M_U+M_D);
    if E>0
        
    
    end
end