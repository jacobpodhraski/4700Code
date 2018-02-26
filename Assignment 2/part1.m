close all;
clear
%Part 1 a)
w = 300;
l = 200;
v0 = 3;
v=v0;
a = zeros(200,300);
a(:,1) = v0;
a(:,l) = 0;
time = 1000000000;
timestep = 1;
figure(1);
% title 'Part 1 A'
% xlabel 'length';
% ylabel 'width'
% zlabel 'Velocity';
for x = 0:timestep:time
    for i=2:1:199
        for j = 2:1:299
            a(i,j) = (a(i+1,j) + a(i-1,j) + a(i,j-1) + a(i,j+1))/4;
        end
    end
    surf(a);
    shading interp;
    grid on;
    title 'Part 1 a';
    xlabel 'Length';
    ylabel 'Width';
    zlabel 'V(x,y)';
    pause(0.0000000005);
end
