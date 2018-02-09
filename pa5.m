close all;
clear
nx = 50;
ny = 50;
G = zeros (nx*ny,nx*ny);
j = 1;
for i=1:1:2500
    G(i,j) = 1;
    j = j +1;
end    
        


for i=1:1:ny
    for j=1:1:nx
        n = j +(i-1) *ny;
        if i==1 || i==nx
            G(n,:) = 0;
            G(n,n) = 1;
        elseif j==1 || j ==ny
             G(n,:) = 0;
             G(n,n) = 1;
        else 
            G(n,n) = -4;
            G(n, j+1+(i-1)*ny) = 1;
            G(n , j + i*nx)=1;
            G(n,j+(i-2)*nx) = 1;
            G(n,j-1 +(i-1)*nx) = 1;
            
        end   
    end
end

[E,D] = eigs(G,9,'SM');
X = zeros(nx,ny,9);
for i = 1:9
   X(:,:,i) = reshape(E(:,i),[nx,ny]);
   figure(i);
   surf(X(:,:,i));
end
               