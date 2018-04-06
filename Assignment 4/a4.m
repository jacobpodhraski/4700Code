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
legend ("Output","Input");
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
legend ("Output","Input");
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
title 'Histogram of Capacitor values';
grid minor;

%Part 2 A
step =0.001;
A = C/step + G; 
Vold = [1;0;0;0;0;0;0];
Vnew = [1;0;0;0;0;0;0];
count = 1;
for i=0.001:0.001:1000*10^-3
    
    if count<30
          F(1,1) = 0;
            V = G\F;
            Vout(count,1) = i;
            Vout(count,2) = V(7);
            
            
    else
            F(1,1) = 1;
            Vnew = inv(A)*(F + C*Vold./step);
            Vold = Vnew;
            Vout(count,1) = i;
            Vout(count,2) = Vnew(7);
            Vout(count,3) = Vnew(1);
           
    end    
    count = count + 1;
end
% Time Domain

figure (4);
plot(Vout(:,1), Vout(:,2),'r');
hold on;
plot(Vout(:,1), Vout(:,3),'b');
title 'Step Function Sweep';
xlabel 'time (s)';
ylabel 'Vout';
legend ("Output","Input");
grid minor;
% Frequency Plot
VoutFnoshift = fft(Vout(:,2));
VinFnoshift = fft(Vout(:,3));
VinF = fftshift(VinFnoshift);
VoutF = fftshift(VoutFnoshift);
figure(5);
semilogy (abs(VoutF));
hold on;
semilogy(abs(VinF));
legend("Output","Input");
title 'Step Function in Frequency';
xlabel 'Frequency (Hz)';
ylabel 'Magnitude';
grid minor;




count = 1;
step = 0.001;
Vold = [0;0;0;0;0;0;0];
Vnew = [1;0;0;0;0;0;0];
%Part 2 B
for i=0.001:0.001:1000*10^-3
    
            F(1,1) = sin(2*pi*(1/0.03)*i);
            Vnew = inv(A)*(F + C*Vold./step);
            Vold = Vnew;
            Voutb(count,1) = i;
            Voutb(count,2) = Vnew(7);
            Voutb(count,3) = F(1,1);
           
       
    count = count + 1;
end
figure (6);
plot(Voutb(:,1), Voutb(:,2),'r');
hold on;
plot(Voutb(:,1), Voutb(:,3),'b');
title 'Sine Function Input';
xlabel 'time (s)';
ylabel 'Vout';
legend ("Output","Input");
grid minor;

% Frequency Plot
VoutFbnoshift = fft(Voutb(:,2));
VinFbnoshift = fft(Voutb(:,3));
VoutFb = fftshift(VoutFbnoshift);
VinFb = fftshift(VinFbnoshift);
figure(7);
semilogy (abs(VoutFb));
hold on;
semilogy(abs(VinFb));
legend("Output","Input");
title 'Sine Function in Frequency';
xlabel 'Frequency (Hz)';
ylabel 'Magnitude';
grid minor;

%Part 2 C
count = 1;
step = 0.001;
Vold = [0;0;0;0;0;0;0];
Vnew = [1;0;0;0;0;0;0];
%Part 2 
for i=0.001:0.001:1000*10^-3

                F(1,1) = (exp(-(i-0.06).^2/(2*step)));
                 Vnew = inv(A)*(F + C*Vold./step);
                 Vold = Vnew;
                Voutc(count,1) = i;
                Voutc(count,2) = Vnew(7);
                Voutc(count,3) = F(1,1);
                 
       
    count = count + 1;
end
figure (8);
plot(Voutc(:,1), Voutc(:,2),'r');
hold on;
plot(Voutc(:,1), Voutc(:,3),'b');
title 'Gaussian Pulse Input';
xlabel 'time (s)';
ylabel 'Vout';
legend ("Output","Input");
grid minor;

% Frequency Plot
VoutFcnoshift = fft(Voutc(:,2));
VinFcnoshift = fft(Voutc(:,3));
VinFc = fftshift(VinFcnoshift);
VoutFc = fftshift(VoutFcnoshift);
figure(9);
semilogy (abs(VoutFc));
hold on;
semilogy(abs(VinFc));
legend("Output","Input");
title 'Gaussian Pulse in Frequency';
xlabel 'Frequency (Hz)';
ylabel 'Magnitude';
grid minor;


Cn = 0.00001;
C = zeros(7,7);
C(2,1) = -c;
C(2,2) = c;
C(3,3) = -L;
C(4,4) = -Cn;
% C(6,4) = -Cn;


F = zeros(7,1);

%Part 3

count = 1;
step = 0.01;
Vold = [1;0;0;0;0;0;0];
Vnew = [1;0;0;0;0;0;0];

%Part 2 
for i=0.001:0.001:1000*10^-3
                F(7,1) = randn(1,1);
                F(1,1) = (exp(-(i-0.06).^2/(2*step)));
                Vnew = inv(A)*(F + C*Vold./step);
                Vold = Vnew;
                Vout3(count,1) = i;
                Vout3(count,2) = Vnew(7);
                Vout3(count,3) = F(1,1);
                 
    count = count + 1;
end

figure (10);
plot(Vout3(:,1), Vout3(:,2),'r');
hold on;
plot(Vout3(:,1), Vout3(:,3),'b');
title 'Vout with an input In as Noise';
xlabel 'time (s)';
ylabel 'Vout';
legend ("Output","Input");
grid minor;

% Frequency Plot
Vout3noshift = fft(Vout3(:,2));
Vin3noshift = fft(Vout3(:,3));
VinF3 = fftshift(Vin3noshift);
VoutF3 = fftshift(Vout3noshift);
figure(11);
semilogy (abs(VoutF3));
hold on;
semilogy(abs(VinF3));
legend("Output","Input");
title 'Gaussian Pulse in Frequency with Noise added';
xlabel 'Frequency (Hz)';
ylabel 'Magnitude';
grid minor;



