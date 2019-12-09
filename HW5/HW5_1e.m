clear all
t_steps = [1,2,3,5,10];
N=1e4;

for H = 1:length(t_steps)
    for m = 1:N
        i=1;
        x_track = 0;
        while i<=t_steps(H)
            x_c = 10*rand();
            y_c = rand();
            if y_c<exp(-(x_c-5)^2/5)
                step = x_c*(2*(randi(2)-1)-1);
                x_track = x_track+step;
                i=i+1;
        end
    end
    x_pos(m) = x_track;
end

a = 1;
pos = (-10*t_steps(H):a:10*t_steps(H));
for n = 1:length(pos)
    top = (pos(n)+(a/2))>x_pos;
    uh= x_pos>(pos(n)-a/2);
    lw = (top==uh);
    posc(n) = sum(lw);
    
end
figure(H+10)
plot(pos,posc/(N))
title(sprintf('Q1e (%ddt)',t_steps(H)))
end