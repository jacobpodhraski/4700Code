%Part 2;

close all;
clear
clearvars

nx = 100;
ny = 200;
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
figure(1);
surf(Cmap);
title 'Conductivity Map';
xlabel 'Length';
ylabel 'width';
zlabel 'sigma(x,y)';
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

   figure(2);
   surf(X(:,:));
   title 'Voltage Potential';
   xlabel 'width';
   ylabel 'length';
   zlabel 'V(x,y)';
   
   
   figure(3);
   [Ey,Ex] = gradient(X);
   quiver(Ex,Ey);
   title 'Electric Field';
   xlabel 'x direction';
   ylabel 'y direction';
   
%    figure(4);
%    Jx = Cmap.*Ex;
%    Jy = Cmap.*Ey;
%    quiver(Jx,Jy);
%    title 'Current Density';
%    xlabel 'Jx';
%    ylabel 'Jy';