clear;close all

% HW5
% Daniel Kennedy - djk2120
%    import and plot fortran matrix multiplcation timing data


% import data
data=load('MatrixMultiplyTimers.txt');
n = data(:,1);
t = data(:,2);

% scatter plot data
loglog(n,t,'rx')
set(gca,'xlim',[8 1200])
xlabel('Matrix size')
ylabel('Execution time (s)')
title('Matrix multiplication timing')

% fit linear model in log-log
% note that the slope of the model is 2.949, which is ~3 as expected
G = [ones(3,1),log(n)];
d = log(t);
m = (G'*G)\(G'*d);

% plot model
hold on
loglog(n,exp(G*m),'b-')

% could use model to predict n=10^4,10^5
% but easier to just use big-o
predicted_times = exp([ones(2,1),log([10^4;10^5])]*m);
predicted_times(1);
predicted_times(2);

% print figure
print(gcf,'MatrixMultiplyTimers','-dpdf')
