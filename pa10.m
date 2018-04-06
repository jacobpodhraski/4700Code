close all;
clear

Is = 0.01*10^-12;
Ib=0.1*10^-12;
Vb = 1.3;
Gp = 0.1;
V = linspace(-1.95,0.7,200);
I = Is*(exp(1.2*V/0.025)-1) + Gp*V - Ib*exp(-1.2*(V+Vb)/0.025);
I2 = 0.8+0.4*rand(1,200).*I;

figure(1);
plot(V,I);
title 'I vs V';
xlabel 'V(V)';
ylabel 'I(A)';

figure(2);
plot(V,I2);
hold on;
plot(V,I);
hold off;
title 'I vs V with noise';
xlabel 'V(V)';
ylabel 'I(A)';

figure(3);
fit1 = polyfit(V,I,4);
fit2 = polyval(fit1,V);
plot(V,fit2);
hold on;
plot(V,I);
hold off;
title 'I vs V 4th order';
xlabel 'V(V)';
ylabel 'I(A)';

figure(4);
yes = polyfit(V,I,8);
nope = polyval(yes,V);
plot(V,nope);
hold on;
plot(V,I);
hold off;
title 'I vs V 8th order';
xlabel 'V(V)';
ylabel 'I(A)';

figure(5);
fo = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3))');
ff = fit(V',I',fo);
If = ff(V');
plot(V',If');
% hold on;
% plot(V,I);
% hold off;
title 'I vs V fit(A B C D)';
xlabel 'V(V)';
ylabel 'I(A)';

figure(6);
fo = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+1.3))/25e-3))');
ff = fit(V',I',fo);
If = ff(V');
plot(V',If');
title 'I vs V fit(A B C)';
xlabel 'V(V)';
ylabel 'I(A)';

figure(7);
fo = fittype('A.*(exp(1.2*x/25e-3)-1) + 0.1.*x - C*(exp(1.2*(-(x+1.3))/25e-3))');
ff = fit(V',I',fo);
If = ff(V');
plot(V',If');
% hold on;
% plot(V,I);
% hold off;
title 'I vs V fit(A C)';
xlabel 'V(V)';
ylabel 'I(A)';
 
inputs = V.';
targets = I.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
% view(net);
Inn = outputs;
plot(V,Inn);
