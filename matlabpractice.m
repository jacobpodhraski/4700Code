%function [largest] = matlabpractice(a)
%Return the largest value in an array or set of numbers
%     max = a(1);
%     for i = 1:length(a)
%         if a(i)>max
%             max = a(i);
%         end
%     end
%     largest = max;
    
   % largest = max(a);
%end
   
%s.a = {'A','b','78' 5;'B','H','t',1.0};
%s.b = 94680923760274608245;
%s.c = [1 2 3 4 5 67 8 9];
    
x = linspace(0,1,100);
y = rand(1,100);
%z = 50*(rand(1,100));
%plot(x,y)

%x=0.1:0.1:10;
%y=1:100;
%figure(1);
%quiver(x,y,z)


[X,Y] = meshgrid(x);
F = X.*exp(-X.^2-Y.^2);
surf(X,Y,F);