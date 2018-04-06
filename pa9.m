close all;
clear
R1 = 1;
c = 0.25;
R2 = 2;
L = 0.2;
R3 = 10;
a = 100;
R4 = 0.1;
Ro = 1000;

G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
Go = 1/Ro;

C = zeros(7,7);
C(2,1) = -c;
C(2,2) = c;
C(3,3) = -L;

G = [1 0 0 0 0 0 0;
    -G2 G1+G2 -1 0 0 0 0;
    0 1 0 -1 0 0 0;
    0 0 -1 G3 0 0 0;
    0 0 0 0 -a 1 0;
    0 0 0 G3 -1 0 0;
    0 0 0 0 0 -G4 G4+Go];

F = zeros(7,1);
VO = zeros(20,1);
count =1;
for i=-10:0.2:10
    F(1,1) = i;
    V = G\F;
    yup(count,1) = i;
    yup(count,2) = V(7);
    yup(count,3) = V(4);
    count = count +1;
end

figure (1);
plot(yup(:,1), yup(:,2),'r');
hold on;
plot(yup(:,1),yup(:,3),'b');
title 'Change in VO and V3 for varying Vin';
xlabel 'Vin';
ylabel 'V magnitude';
grid minor;

count = 1;
for i=1:5:100000
    F(1,1) = i;
    V = (G+C*1i*i)\F;
    yup2(count,1) = i;
    yup2(count,2) = 20*log10((V(7)/V(1)));
    
    count = count +1;
end

figure (2);
semilogx(yup2(:,1), yup2(:,2),'r');
title 'Gain over Frequency';
xlabel 'Frequency';
ylabel 'Gain(Db)';
grid minor;

cs = normrnd(c,0.05,1000,1);
count = 1;
for i=1:1:1000
    C(2,1) = -cs(i);
    C(2,2) = -C(2,1);
    F(1,1) = i;
    V = (G+1i*C*pi)\F;
    
    yup3(count,2) =(V(7))/V(1);
    
    count = count +1;
end

figure (3);
hist(real(yup3(:,2)),20);
title 'Histogram of Cap values';
grid minor;

