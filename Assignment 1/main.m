xlimit = 200*10^-9;
xstart = 0;
ylimit = 100*10^-9;
ystart = 0;
i = 1;
j = 1;
init = zeros(100,4);
	while i<=10
        j = 1;
           while j<=4
               if(j==1)
                   randx = rand(1,1);
                   init(i,j)= randx * (200*10^-9); %assign random x position
               elseif(j==2)
                   randy = rand(1,1);
                   init(i,j) = randy * (100*10^-9); %assign random y position
               elseif(j==3)
                   randdirection = rand(1,1);
                   init(i,j) = randdirection * 2 * pi; %assign random direction between 0 adn 2pi in radians
               else
                   
                   init(i,j) = 0.5; %assign random velocity between 0 and 5
               end   
                   j = j + 1;
           end
      i = i + 1;       
    end
    
    
    timestep = 0.000000001;
    finaltime = 0.0001;
    
    
    for i =0:timestep:finaltime
        plot(init(:,1),init(:,2),'b.'); %initialize positions
        axis([0 200*10^-9 0 100*10^-9]); %create plot limits
       
                 for j=1:1:10
                        if ((init(j,1)+init(j,2)*timestep)>=xlimit)
                                init(j,1) = xstart;
                        elseif((init(j,1)+init(j,2)*timestep)<=xstart)
                                init(j,1)=xlimit;
                            
                        end
                 
                       if((init(j,2)+init(j,1)*timestep)>=ylimit)
                            init(j,4) = -init(j,4);
                            init(j,3) = pi - init(j,3);
                       elseif((init(j,2)+init(j,1)*timestep)<=ystart)
                            init(j,4) = -init(j,4);
                            init(j,3) = pi - init(j,3);
                       end
                       
                 end
        init(:,1) = init(:,1) + init(:,4).*cos(init(:,3)).*timestep; %moving x components                          
        init(:,2) = init(:,2) + init(:,4).*sin(init(:,3)).*timestep;
        hold on;
        pause(0.1);
    end
  