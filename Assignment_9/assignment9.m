clear
close all

% load data
data = load('AASZ_topo.txt');
lon = data(:,1);
lat = data(:,2);
x   = 1000*data(:,3);
z   = data(:,4);

% plot profile
subplot(2,1,1)
plot(x/1000,z)
xlabel('Distance (km)')
ylabel('Elevation (m)')
title('Aleutian Profile')
xlim([-1 325])

% compute slope
dzdx  = (z(2:end)-z(1:end-1))./(x(2:end)-x(1:end-1));
angle = 360/(2*pi)*atan(dzdx);

% plot slope
subplot(2,1,2)
x2    = 0.5*(x(2:end)+x(1:end-1)); %halfway points
plot(x2/1000,angle)
xlabel('Distance (km)')
ylabel('Slope (degrees)')
xlim([-1 325])

print('AASZ_topo_slope','-dpdf')



a = ncinfo('us.nc');