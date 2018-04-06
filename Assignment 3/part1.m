    close all;
    clear;


    numpart = 10;

    q = 1.602*10^-19;
    xlimit = 200*10^-9;
    xstart = 0;
    ylimit = 100*10^-9;

    ystart = 0;
    i = 1;
    j = 1;
    init = zeros(numpart,6);
    previous = zeros(numpart,2);

    temp = 300;
    m0 = 9.11*10^-31;
    mn = 0.26*m0;
    kb = 1.38*10^-23;


    amount = 10;
    v = sqrt((2*kb*temp)/mn);
    
    colour = hsv(numpart);

tmn = 0.2*10^-12;
pscat = 1 - exp(-0.00000000000001/tmn);

    %ASSINGMENT 3 CODE
    voltage = 0.5; 
    efield = voltage / xlimit; % efield = 2500000
    force  = efield * q; % force = 4.0050e-13
    a = force/mn; % a = 1.6909e+18



    while i<=numpart
        j = 1;
        while j<=6


            if(j==1)
                randx = rand(1,1);
                init(i,j)= randx * (200*10^-9); %assign random x position
            elseif(j==2)
                randy = rand(1,1);
                init(i,j) = randy * (100*10^-9); %assign random y position
            elseif(j==3)
                randd= rand(1,1);
                init(i,j) = randd*2*pi;
            elseif(j==4)
    %             randvx = randn(1,1);
    %             vx = (v/sqrt(2))*randvx;
    %             randvy = randn(1,1);
    %             vy = (v/sqrt(2))*randvy;
    %             vth = sqrt(vx^2+vy^2);
    %             init(i,j) = vth;
                init(i,j) = v;
            elseif(j==5)
                randvx = randn(1,1);
                vx = (v/sqrt(2))*randvx;
                init(i,j) = vx;
            else
                randvy = randn(1,1);
                vy = (v/sqrt(2))*randvy;
                init(i,j) = vy;


            end

            j = j + 1;

        end        
        i = i +1;
    end


    timestep = 0.00000000000001;
    finaltime = 0.000000000001;
     total = finaltime/timestep;
     T = zeros(1,total);
     timeaxis = zeros(1,total);
    count = 1;
    time = 0;
    for i =0:timestep:finaltime
        figure(1);
        title 'Part 1: 2-D Trajectories of Electrons';
        hold on;
        pause(0.001);
          
           
        
        for j=1:1:numpart

            if ((init(j,1)+init(j,2)*timestep)>=xlimit)
                init(j,1) = xstart;
                previous(j,1) = xstart;
            elseif((init(j,1)+init(j,2)*timestep)<=xstart)
                init(j,1)=xlimit;
                previous(j,1) = xlimit;

            end

            if((init(j,2)+init(j,1)*timestep)>=ylimit)
%                 init(j,4) = -init(j,4);
%                 init(j,3) = pi - init(j,3);
                  init(j,6) = -init(j,6);


            elseif((init(j,2)+init(j,1)*timestep)<=ystart)
%                 init(j,4) = -init(j,4);
%                 init(j,3) = pi - init(j,3);
                    init(j,6) = -init(j,6);

            end
            for h=1:1:numpart
                scatter = rand(1,1);
                if scatter <= 0.009
                     randvy = randn(1,1);
                     vy = (v/sqrt(2))*randvy;
                     init(h,6) = vy;
                     randvx = randn(1,1);
                     vx = (v/sqrt(2))*randvx;
                     init(h,5) = vx;   
                     
                end
            end
            if i~=0
                plot([previous(j,1),init(j,1)],[previous(j,2),init(j,2)],'color',colour(j,:)); %initialize positions
                axis([0 200*10^-9 0 100*10^-9]);



            end
        end
    %     for x =1:1:30
    %         init(:,4) = init(:,4) + 1000;
    %     end
        previous (:,1) = init(:,1);
        previous (:,2) = init(:,2);

    %     init(:,1) = init(:,1) + (init(:,4)).*cos(init(:,3)).*timestep;
    %     init(:,2) = init(:,2) + (init(:,4)).*sin(init(:,3)).*timestep;
            
    
    init(:,5) = (init(:,5) + a*timestep); %Adding effect of an Ex field
            
            
%             init(:,6) = (init(:,6) + a*timestep);
            
         init(:,1) = init(:,1) + (init(:,5)).*timestep;
         init(:,2) = init(:,2) + init(:,6).*timestep;
         temp = 300;
         
         
         for g=1:numpart
         temp = ((init(g,5).^2+init(g,6).^2) *mn )/(2* kb);
         temp = temp + temp;
         end
            average = temp/numpart;
            T(1,count) = average;
            time = time + timestep;
            timeaxis(1,count) = time; 
       
        count = count +1;

    end

         figure(3);
         plot(timeaxis,T);
         title 'Temperature Plot over time';
         ylabel 'Temperature (K)';
         xlabel 'time (s)';
