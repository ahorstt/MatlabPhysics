clc;
close all;
l = 10;
delta = 1;

nsamples = 22000;
pdf= @(x) 2000*exppdf(x,1);
proppdf= @(x,y) unifpdf(y-x, -delta,1);
proprnd =@(x) x + rand*2*delta - delta;

smpl = mhsample(1,nsamples,'pdf',pdf,'proprnd',proprnd,'proppdf',proppdf);
fplot(pdf,[0 10]); 

hold on ;
histogram(smpl,100,'DisplayStyle','stairs')
hold off;
ylabel('Frequency');
xlabel('x');
title('1b')
legend('analytic','monte-carlo')