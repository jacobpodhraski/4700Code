
close all;
clear
clearvars

nx = 50;
ny = 50;
G = zeros (nx*ny,nx*ny);
j = 1;
o0 = 1;
o1 = 0.1;
total = nx*ny;
for i=1:1:total
    G(i,j) = 1;
    j = j +1;
end


Cmap = zeros(ny,nx); % Create a spatial conductivity matrix
for i=1:1:ny
    for j=1:1:nx
      
            Cmap(i,j) = 1;
    end
end
figure(1);
surf(Cmap);
F = zeros(nx*ny,1);

for i=1:1:ny
    for j=1:1:nx
        n = j +(i-1)*nx;
        if i==1
            G(n,:) = 0;
            G(n,n) = 1;
            F(n,1) = 1;
        elseif i==ny
            G(n,:) = 0;
            G(n,n) = 1;
            F(n,1) = 0;
        elseif j== 1 
            G(n, n+1) = 1/((1/(2*Cmap(i+1,j))) + (1/(2*Cmap(i,j))));             
            G(n , n-1)= 1/((1/(2*Cmap(i-1,j))) + (1/(2*Cmap(i,j))));
            G(n,n+nx) = 1/((1/(2*Cmap(i,j+1))) + (1/(2*Cmap(i,j))));

            G(n,n) = -(G(n,n+1) + G(n,n-1) + G(n,n+nx));
        
        elseif j == nx
            G(n, n+1) = 1/((1/(2*Cmap(i+1,j))) + (1/(2*Cmap(i,j))));             
            G(n , n-1)= 1/((1/(2*Cmap(i-1,j))) + (1/(2*Cmap(i,j))));
             G(n,n-nx) = 1/((1/(2*Cmap(i,j-1))) + (1/(2*Cmap(i,j))));
            G(n,n) = -(G(n,n+1) + G(n,n-1) + G(n,n-nx));
           
        else
            
            if Cmap(i,j-1) ~= Cmap(i,j)
                
            end
            
            G(n, n+1) = 1/((1/(2*Cmap(i+1,j))) + (1/(2*Cmap(i,j))));
            G(n , n-1)= 1/((1/(2*Cmap(i-1,j))) + (1/(2*Cmap(i,j))));
            G(n,n-nx) = 1/((1/(2*Cmap(i,j-1))) + (1/(2*Cmap(i,j))));
            G(n,n+nx) = 1/((1/(2*Cmap(i,j+1))) + (1/(2*Cmap(i,j))));
            G(n,n) = -(G(n,n+1) + G(n,n-1) + G(n,n-nx) + G(n,n+nx));
        end   
    end
end

V = G\F;
X = zeros(ny,nx,1);
for i=1:1:ny
    for j=1:1:nx
        n = j +(i-1)*nx;
        X(i,j) = V(n);
    end
end

   figure(2);
   surf(X(:,:,1));
   title 'Voltage Potential';
   xlabel 'width';
   ylabel 'length';
   zlabel 'V(x,y)';
   