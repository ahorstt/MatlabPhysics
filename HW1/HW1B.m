 F0 = 1;%initial Values
 F = .5*(sqrt(5)-1);
 A = [F0 F];%array for values
 for n = 3:80%find next value, add to array
  t = F0-F;
  A(n)=t;
  F0 = F;
  F = t; 
 end
values = abs(A);
B = [];
for i = 1:80%multiplication values
    f = (.5*(sqrt(5)-1)).^i;
    B(i) = f;
end
values2 = abs(B)
figure
semilogy(values)
hold on;
plot(values2)
hold off;
xlabel('n')
ylabel('phi^n')