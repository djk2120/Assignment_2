clear
close all

% set up for reading data
fid = fopen('slurm-3726266.out','r');
data = nan(8,2);
data(:,1) = [1,2,3,6,12,24,48,96];

% read data from std_out
while ~feof(fid)
    a = strsplit(fgetl(fid));
    b = fgetl(fid);
    c = fgetl(fid);
    d = strsplit(fgetl(fid));
    
    np = str2double(a{end});
    t  = str2double(d{end});
    ix = data(:,1)==np;
    data(ix,2) = nanmin(data(ix,2),t);
end

%write data to table
dlmwrite('data.txt',data,'delimiter','\t')


% fit linear model in log-log
m = polyfit(log10(data(:,1)),log10(data(:,2)),1);
x = data(:,1);
y = 10.^(polyval(m,log10(x)));

% plot data
xdk = figure;
loglog(data(:,1),data(:,2),'.','MarkerSize',15)
hold on
loglog(x,y,'r:')
xlim(10.^[-0.1,2.1])
ylim(10.^[-0.4,1.8])
xlabel('# of processors')
ylabel('wall time (s)')
title('Habanero test: n = 10^8')

%write image file
xdk.Units         = 'inches';
xdk.PaperPosition = [1 6 4 3.9];
print(xdk,'output','-dpdf')
