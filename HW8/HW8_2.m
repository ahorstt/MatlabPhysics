clear all
A = ones(25);


Kb = (1.3806*10^(-23)); %boltzman constant



S = 10^4; %number of samplings
count = 1;
for Temp = 0.5:0.1:4
    TempV_mem(count) = Temp;
    T = 200;
    J = T*Temp;
    TVar = J/T;
    tau = Kb*T; %tau from boltzman constant
    k = 1;
    for n = 1:S
        x = randi(25); %random i position
        y = randi(25); %random j position

        %Calculating total energy from nearest neightboors
        if x == 25
            M_R = A(1,y);
        else
            M_R = A(x+1,y);
        end
        if y == 25
            M_D = A(x,1);
        else
            M_D = A(x,y+1);
        end
        if y == 1
            M_U = A(x,25);
        else
            M_U = A(x,y-1);
        end
        if x == 1
            M_L = A(25,y);
        else
            M_L = A(x-1,y);
        end
        %Summing total energy
        E = -1*J*A(x,y)*(M_L+M_R+M_U+M_D); %total nearest neighboor energy

        if E>1
            %Spin flip if E is positive
            A(x,y) = -1*A(x,y);
        elseif E<0
            %Thermal fluxuations can still cause flips
            P = exp(2*(-E/J)*TVar/Kb); %finding probability
            if rand()>P
                %random flip occurs
                A(x,y) = -1*A(x,y);
            end
        end
        k = k+1;
    end
    Mag = mean(mean(A));
    Ans(count) = Mag; %saving mag memory
    count = count+1;
end
figure(2)
close(2)
figure(2)
plot(TempV_mem,Ans)
hold on