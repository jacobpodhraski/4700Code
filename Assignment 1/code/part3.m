close all;
clear;


xlimit = 200*10^-9;
xstart = 0;
ylimit = 100*10^-9;
xbox1 = 75*10^-9;
xbox2 = 125*10^-9;
ybox1 = 40*10^-9;
ybox2 = 60*10^-9;
ystart = 0;
i = 1;
j = 1;
init = zeros(30,4);
previous = zeros(30,2);

temp = 300;
m0 = 9.11*10^-31;
mn = 0.26*m0;
kb = 1.38*10^-23;


amount = 10;
v = sqrt((2*kb*temp)/mn);

colour = hsv(30);

tmn = 0.2*10^-12;
pscat = 1 - exp(-0.00000000000001/tmn);

while i<=30
    j = 1;
    while j<=4
        
        
        if(j==1)
            randx = rand(1,1);
            init(i,j)= randx * (200*10^-9); %assign random x position
        elseif(j==2)
            randy = rand(1,1);
            init(i,j) = randy * (100*10^-9); %assign random y position
        elseif(j==3)
            randd= rand(1,1);
            init(i,j) = randd*2*pi;
        else
            randvx = randn(1,1);
            vx = (v/sqrt(2))*randvx;
            randvy = randn(1,1);
            vy = (v/sqrt(2))*randvy;
            vth = sqrt(vx^2+vy^2);
            init(i,j) = vth;
            
            
            %                             %histogram
            %                             figure(1);
            %                             hold on;
            %                             histogram (vth,100);
            
        end
        
        j = j + 1;
        
        
    end
    if(init(i,1)>= 75*10^-9 && init(i,2)>=60*10^-9 && init(i,1)<= 125*10^-9 && init(i,2)<=100*10^-9)
        i = i-1;
    elseif(init(i,1)>= 75*10^-9 && init(i,2)>=0 && init(i,1)<= 125*10^-9 && init(i,2)<=40*10^-9)
        i = i -1;
    else
        i = i + 1;
    end
end


timestep = 0.00000000000001;
finaltime = 0.01;

%     figure(2);
for i =0:timestep:finaltime
    
    
    
    for j=1:1:30
        
        if ((init(j,1)+init(j,2)*timestep)>=xlimit)
            init(j,1) = xstart;
            previous(j,1) = xstart;
        elseif((init(j,1)+init(j,2)*timestep)<=xstart)
            init(j,1)=xlimit;
            previous(j,1) = xlimit;
            
        end
        
        if((init(j,2)+init(j,1)*timestep)>=ylimit)
            init(j,4) = -init(j,4);
            init(j,3) = pi - init(j,3);
            
        elseif((init(j,2)+init(j,1)*timestep)<=ystart)
            init(j,4) = -init(j,4);
            init(j,3) = pi - init(j,3);
            
        end
        
        if(init(j,1) >=  xbox1 && init(j,2)>=ybox2 && init(j,1) <= xbox2)
            if (init(j,1)>= xbox1 && previous (j,1)<=xbox1)
                init (j,1) = previous(j,1);
                if init(j,1)>= xbox1 && init(j,1)<=xbox2
                    
                    init(j,4) = -init(j,4);
                end
                %init( j,2) = previous(j,2);
                %init(j,4) = -init(j,4);
                init(j,3) = pi - init(j,3);
            else
                init(j,1) = previous(j,1);
                if init(j,1)>= xbox1 && init(j,1)<=xbox2
                    
                    init(j,4) = -init(j,4);
                end
                %init( j,2) = previous(j,2);
                %init(j,4) = -init(j,4);
                init(j,3) = pi - init(j,3);
            end
            
        elseif(init(j,1)>=xbox1 && init(j,2) <=ybox1 && init(j,1) <= xbox2)
            if (init(j,1)>= xbox1 && previous(j,1) <= xbox1)
                init (j,1) = previous(j,1);
                %init( j,2) = previous(j,2);\
                if init(j,1)>= xbox1 && init(j,1)<=xbox2
                    init(j,2) = previous(j,2);
                    init(j,4) = -init(j,4);
                end
                
                init(j,3) = pi - init(j,3);
            else
                init(j,1) = previous(j,1);
                if init(j,1)>= xbox1 && init(j,1)<=xbox2
                    init(j,2) = previous(j,2);
                    init(j,4) = -init(j,4);
                end
                %init( j,2) = previous(j,2);
                %init(j,4) = -init(j,4);
                init(j,3) = pi - init(j,3);
            end
            
            
        end
        
       if pscat > rand()
           randnew = rand(1,1);
           init(j,3) = randnew * 2 * pi;
           randvx = randn(1,1);
            vx = (v/sqrt(2))*randvx;
            randvy = randn(1,1);
            vy = (v/sqrt(2))*randvy;
            vth = sqrt(vx^2+vy^2);
            init(j,4) = vth;
       end    
        
        
        if i~=0
            plot([previous(j,1),init(j,1)],[previous(j,2),init(j,2)],'color',colour(j,:)); %initialize positions
            rectangle('Position',[75*10^-9,60*10^-9,50*10^-9,40*10^-9]);
            rectangle('Position',[75*10^-9,0,50*10^-9,40*10^-9]);
            axis([0 200*10^-9 0 100*10^-9]);
        end
    end
    previous (:,1) = init(:,1);
    previous (:,2) = init(:,2);
    
    init(:,1) = init(:,1) + init(:,4).*cos(init(:,3)).*timestep; %moving x components
    init(:,2) = init(:,2) + init(:,4).*sin(init(:,3)).*timestep;
%     
%         scatter = rand(1,1);
%        newdirection = rand(1,1);
%        newd = newdirection * 2 * pi;
%        if scatter <= 0.005
%            init(:,3) = newd;
%        end  
%     
    title 'Part 3: 2-D Trajectories of Electrons';
    hold on;
    pause(0.0000000001);
end
