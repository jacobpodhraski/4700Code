close all;
clear

a = 100;
b = 100;
v = zeros(a,b);
v(:,1)=1;
v(:,100) = 1;

time = 10000000000000000000000;
timestep = 1;

for x = 0:timestep:time

    for i=2:1:99
            for j = 2:1:99
                  
                    
                
%                 if i == 1
%                         v(i,j) = (v(i+1,j)+v(i-1,j)+v(i,j+1))/3;
%                 elseif j==1
%                         v(i,j) = (v(i+1,j)+v(i-1,j)+v(i,j-1))/3;
%                 else        
                        v(i,j) = (v(i+1,j) + v(i-1,j) + v(i,j-1) + v(i,j+1))/4;
%                 end
                
                 
            end   
    end 
                 surf(v);
                 pause(0.005);
end