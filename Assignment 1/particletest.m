% script that simulates a moving particle with some initial velocity in a
% magnetic field B
v0 = [5 0 0]; %initial velocity
B = [0 0 -5]; %magnitude of B
m = 5; % mass
q = 1; % charge on particle
r0 = [0 0 0]; % initial position of particle
t = 0;
% Now we want to find the next velocity as the particle enters the magnetic
% field and hence its new position
r = r0;
v = v0;
dt = 0.00000000000000000001;
figure
xlim([-25 25])
ylim([-25 25])
hold on
for n = 1:100
%plot it
plot(r(1),r(2),'*');
%pause
% update time
t = t+dt;
% new position r
dr = v*dt; 
r = r + dr;
%find new velocity
dv = (q/m) * cross(v,B);
v = v + dv;
end 
