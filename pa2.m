dot = zeros(1,2);
dot(1,1) = 0; %xposition at x=0
dot(1,2) = 1; %initial velocity of particle
ylimit = 1;

timestep = 0.000000001;
finaltime = 0.0001;
 
for i =0:timestep:finaltime
    plot(dot(1,1),50*10^-9,'or');
    axis([0 1*10^-6 0 100*10^-9]);
    
    dot(1,1)= dot(1,1) + dot(1,2).*pi*timestep;
        for j=1:1:2
            random = rand(1,1);
                if random <= 0.05
                    dot(1,2) = 0;
                end
        end
        
    pause(0.5);
    hold on;
    dot(1,2) = dot(1,2) +1;
end   
