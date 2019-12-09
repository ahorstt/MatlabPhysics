clear
N=100;
c=1;
dx = 0.01;
dt = 0.001;
A = diag(-2*ones(N,1),0)+diag(ones(N-1,1),1)+diag(ones(N-1,1),-1);
[V,D] = eigs(A,3,'SM');
for n = 1:3
plot(V(:,n),'o');
hold on;
end
hold off;
title('Question 3 Eigenvectors')
xlabel('X')
ylabel('Y')
[V,D] = eig(A);
x = diag(D)';
B = sqrt(abs(fliplr(x)));
figure
plot(B,'o')
hold on;
plot(c*dx/dt*sin((1:length(diag(D))).*dx/3))
hold off;
title('Question 3 Frequency Plot')
xlabel('Mode')
ylabel('Frequency')
