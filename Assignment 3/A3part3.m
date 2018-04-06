    close all;
        clear;
nx = 200;
ny = 100;
G = sparse (nx*ny,nx*ny);
j = 1;
o0 = 1;
o1 = 1;
total = nx*ny;
% for i=1:1:total
%     G(i,j) = 1;
%     j = j +1;
% end


Cmap = zeros(ny,nx); % Create a spatial conductivity matrix
for i=1:1:ny
    for j=1:1:nx
%         if i >= 0.5*nx
%              Cmap(i,j) = .1;
%         else
%             Cmap(i,j) = 1;
%         end
        if i>=75 && i<=125 && j<=40
            Cmap(i,j) = .01;
        elseif i>=75 && i<=125 && j>=60
            Cmap(i,j) = .01;
        else
            Cmap(i,j) = 1;
        end
    end
end
% figure(1);
% surf(Cmap);
% title 'Conductivity Map';
% xlabel 'Length';
% ylabel 'width';
% zlabel 'sigma(x,y)';
F = zeros(nx*ny,1);

for i=1:1:ny
    for j=1:1:nx
        n = j +(i-1)*nx;
        nip = j + (i+1-1)*nx;
        nim = j + (i-1-1)*nx;
        njp = j+1 + (i-1)*nx;
        njm = j-1 + (i-1)*nx;
        
        if i==1
            G(n,:) = 0;
            G(n,n) = 1;
            F(n,1) = 1;
        elseif i==ny
            G(n,:) = 0;
            G(n,n) = 1;
            F(n,1) = 0;
        elseif j== 1 
            %             G(n, n+1) = 1/((1/(2*Cmap(i+1,j))) + (1/(2*Cmap(i,j))));
            %             G(n , n-1)= 1/((1/(2*Cmap(i-1,j))) + (1/(2*Cmap(i,j))));
            %             G(n,n+nx) = 1/((1/(2*Cmap(i,j+1))) + (1/(2*Cmap(i,j))));
            %
            %             G(n,n) = -(G(n,n+1) + G(n,n-1) + G(n,n+nx));
            G(n, nip) = (Cmap(i+1,j)+ Cmap(i,j)) / 2;
            G(n , nim)= (Cmap(i-1,j) + Cmap(i,j))/2;            
            G(n,njp) = (Cmap(i,j+1)+ Cmap(i,j))/2;
            G(n,n) = -(G(n,nip) + G(n,nim) +  G(n,njp));
            
        elseif j == nx
            %             G(n, n+1) = 1/((1/(2*Cmap(i+1,j))) + (1/(2*Cmap(i,j))));
            %             G(n , n-1)= 1/((1/(2*Cmap(i-1,j))) + (1/(2*Cmap(i,j))));
            %             G(n,n-nx) = 1/((1/(2*Cmap(i,j-1))) + (1/(2*Cmap(i,j))));
            %             G(n,n) = -(G(n,n+1) + G(n,n-1) + G(n,n-nx));
            G(n, nip) = (Cmap(i+1,j)+ Cmap(i,j)) / 2;
            G(n , nim)= (Cmap(i-1,j) + Cmap(i,j))/2;
            G(n , njm) = (Cmap(i,j-1) + Cmap(i,j))/2;
            
%             if G(n, n+1) ~= G(n,n-1) || G(n, n+1) ~= G(n,n-nx)
%                 pause(0.1)
%             end
            
            
            G(n,n) = -(G(n,nip) + G(n,nim) + G(n,njm));
        else
            %
            %             if Cmap(i,j-1) ~= Cmap(i,j)
            %
            %             end
            %
            %             G(n, n+1) = 1/((1/(2*Cmap(i+1,j))) + (1/(2*Cmap(i,j))));
            %             G(n , n-1)= 1/((1/(2*Cmap(i-1,j))) + (1/(2*Cmap(i,j))));
            %             G(n,n-nx) = 1/((1/(2*Cmap(i,j-1))) + (1/(2*Cmap(i,j))));
            %             G(n,n+nx) = 1/((1/(2*Cmap(i,j+1))) + (1/(2*Cmap(i,j))));
            %             G(n,n) = -(G(n,n+1) + G(n,n-1) + G(n,n-nx) + G(n,n+nx));
            
            G(n, nip) = (Cmap(i+1,j)+ Cmap(i,j)) / 2;
            G(n , nim)= (Cmap(i-1,j) + Cmap(i,j))/2;
            G(n,njm) = (Cmap(i,j-1) + Cmap(i,j))/2;
            G(n,njp) = (Cmap(i,j+1)+ Cmap(i,j))/2;
            G(n,n) = -(G(n,nip) + G(n,nim) + G(n,njm) + G(n,njp));
            
            
            
        end
    end
%     if ~issymmetric(G)
%         pause(0.1)
%     end
    
end

V = G\F;

X = zeros(nx,ny);
for i=1:1:ny
    for j=1:1:nx
         n = j +(i-1)*nx;

        X(j,i) = V(n);

    end
end

%    figure(2);
%    surf(X(:,:));
%    title 'Voltage Potential';
%    xlabel 'width';
%    ylabel 'length';
%    zlabel 'V(x,y)';
   
   
%    figure(3);
%    [Ey,Ex] = gradient(X);
%    quiver(Ex,Ey);
%    title 'Electric Field';
%    xlabel 'x direction';
%    ylabel 'y direction';

        numpart = 5;

        q = 1.602*10^-19;


    xlimit = 200*10^-9;
    xstart = 0;
    ylimit = 100*10^-9;
    xbox1 = 75*10^-9;
    xbox2 = 125*10^-9;
    ybox1 = 40*10^-9;
    ybox2 = 60*10^-9;
    i = 1;
    j = 1;
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



        %ASSINGMENT 3 PART 3 CODE
        voltage = 0.5; 
        [Ex,Ey] = gradient(X);
        forcex  = Ex * q;
        forcey = Ey *q;
        ax = forcex/mn;
        ay = forcey/mn;


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
%                     rand2 = randn(1,1);
%                     if rand2<0.9
%                         init(i,j) = -init(i,j);
%                     end
                else
                    randvy = randn(1,1);
                    vy = (v/sqrt(2))*randvy;
                    init(i,j) = vy;
%                     rand2 = randn(1,1);
%                     if rand2<0.9
%                         init(i,j) = -init(i,j);
%                     end


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
        finaltime = 0.000000000001;
         total = finaltime/timestep;
         T = zeros(1,total);
         timeaxis = zeros(1,total);
        count = 1;
        time = 0;
        for i =0:timestep:finaltime
            figure(5);
            title 'Part 2: 2-D Trajectories of Electrons';
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

                elseif(init(j,1)>=xbox1 && init(j,1) <=xbox2 && init(j,2)>=ybox2 &&init(j,5)>=0 && previous(j,1)<=xbox1)
                    init(j,1) = xbox1; 
                    init(j,5) = -init(j,5);
                 
                elseif(init(j,1)<=xbox2 && init(j,1)>=xbox1 && init(j,2)>=ybox2 && init(j,5)<0 && previous(j,2)>=xbox2)
                    init(j,1) = xbox2;
                    init(j,5) = -init(j,5);
                
                elseif(init(j,1)>=xbox1 && init(j,1) <=xbox2 && init(j,2)<=ybox1 &&init(j,5)>=0 && previous(j,1)<=xbox1)
                    init(j,1) = xbox1; 
                    init(j,5) = -init(j,5);
                 
                elseif(init(j,1)<=xbox2 && init(j,1)>=xbox1 && init(j,2)<=ybox1 && init(j,5)<0 && previous(j,1)>=xbox2)
                    init(j,1) = xbox2;
                    init(j,5) = -init(j,5);
                    
                 elseif(init(j,1)>=xbox1 && init(j,1)<=xbox2)
                     if(init(j,2)>=ybox2)
                         init(j,2) = ybox2;
                         init(j,6) = -init(j,6);
                     elseif(init(j,2)<=ybox1)
                         init(j,2) = ybox1;
                         init(j,6) = -init(j,6);
                     end
                     
                
                end
                
    %             for h=1:1:numpart
    %                 scatter = rand(1,1);
    %                 if scatter <= 0.018
    %                      randvy = randn(1,1);
    %                      vy = (v/sqrt(2))*randvy;
    %                      init(h,6) = vy;
    %                      randvx = randn(1,1);
    %                      vx = (v/sqrt(2))*randvx;
    %                      init(h,5) = vx;   
    %                      
    %                 end
    %             end
                if i~=0
                     plot([previous(j,1),init(j,1)],[previous(j,2),init(j,2)],'color',colour(j,:)); %initialize positions
            rectangle('Position',[75*10^-9,60*10^-9,50*10^-9,40*10^-9]);
            rectangle('Position',[75*10^-9,0,50*10^-9,40*10^-9]);
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
                
                for m=1:1:numpart 
                roundx = round(init(m,1)*10^9); %round the x position to get an index
                roundy = round(init(m,2)*10^9); %round the y position to get an index
              
                
                init(m,5) = (init(m,5) + ax(roundx,roundy).*timestep);
                init(m,6) = (init(m,6) + ay(roundx,roundy).*timestep);
                end
    %             
    init(:,6) = (init(:,6) + a*timestep);

             init(:,1) = init(:,1) + (init(:,5)).*timestep;
             init(:,2) = init(:,2) + init(:,6).*timestep;
%              temp = 300;
%              for g=1:numpart
%              temp = ((init(g,5).^2+init(g,6).^2) *mn )/(2* kb);
%              temp = temp + temp;
%              end
%                 average = temp/numpart;
%                 T(1,count) = average;
%                 time = time + timestep;
%                 timeaxis(1,count) = time; 
% 
%             count = count +1;

        end
% 
%              figure(3);
%              plot(timeaxis,T);
%              title 'Temperature Plot over time';
%              ylabel 'Temperature (K)';
%              xlabel 'time (s)';
