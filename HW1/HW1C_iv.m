clear
syms x
c = int(exp(x),x,0,1);%definite integral for error use
i = 0;%counter
n = logspace(2,5,10);%sample sizes
B = zeros(size(n));%array for errors
for n=round(n)%use sample sizes (rounded)
    a=0;
    b=1;%x bounds
    e = exp(1);%y bound
    y = e.*rand(1,n);%random points
    x = rand(1,n);
    count = 0;%counter
    for k=1:numel(x)%determines # of points under curve
          if y(k) <= exp(x(k))
              count= count + 1;
          end
    end
    count;
    integral = count/numel(x).*e;%finds est integral
    err = abs(c-integral);%error
    i = i+1;
    B(i) = err;
end
figure
n = logspace(2,5,10);%sample sizes (redefined)
loglog(n,B)
xlabel('samples')
ylabel('absolute error')