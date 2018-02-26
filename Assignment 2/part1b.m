%Part 1b;
close all;
clear
v0 = 3;
a = 200;
b = 300;
v = zeros(a,b);
v(:,1)=v0;
v(:,b) = v0;
time = 10000000;
timestep = 1;
for x = 0:timestep:time
    
    for i=2:1:199
        for j = 2:1:299
            v(i,j) = (v(i+1,j) + v(i-1,j) + v(i,j-1) + v(i,j+1))/4;
        end
    end
    surf(v);
    shading interp;
    grid on;
    title 'Part 1 b';
    xlabel 'Length';
    ylabel 'Width';
    zlabel 'V(x,y)';
    pause(0.005);
end
