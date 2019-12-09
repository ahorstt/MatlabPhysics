clear all
clc
digits(8)

a=1;
x=-a:0.01:a;
pi=22/7;


for ii = [4,8,16]
    N=ii;
    n=N-1;

for i=0:n;
 for j=0:n;
     
     if mod((i+j),2)==0     
         
A(i+1,j+1)=(2.0/(i+j+5.0))-(4.0/(i+j+3.0))+(2.0/(i+j+1.0));

     else
A(i+1,j+1)=0;

     end
end 
end 

 for i=0:n
   for j=0:n
       if mod((i+j),2)==0 
          
     H(i+1,j+1)=(-8.0*(1.0-i-j-2.0*i*j))/((i+j+3)*(j+i+1)*(i+j-1));
     
          else
     H(i+1,j+1)=0;
     end
   end 
 end 

 f = [];
for i = 1:N;

    n = i-1;

    f(i,:) = (x.^(n+2)-(a^2*x.^n))/(a^(n+2.5));

end

[V,D] = eig(H,A); 

Y = (V'*f)';

figure;
subplot(2,1,1);
plot(diag(D),'o');
xlabel('Quantum Number');
ylabel('Energy');
legend(['N =' num2str(ii)])
subplot(2,1,2);
plot(abs(Y(:,1:3)).^2);
xlabel('Position');
ylabel('|\psi|^2');
axis([0 200 0 1.5])
end