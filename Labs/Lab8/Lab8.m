%% Lab 8 Reveiw convolution, functions, and SD
% Name
% COntact info, etc
% This requires the normalize function in this folder

%% 0 Init 
clear all
close all
clc

%%
x = 0:pi/4:2*pi; % Should correspond to days that are not missing
v = sin(x); % data that is not missing
xq = 0:pi/16:2*pi; % Days that have data that IS missing

figure
vq1 = interp1(x,v,xq);
plot(x,v,'o',xq,vq1,':.');
xlim([0 2*pi]);
title('(Default) Linear Interpolation');


figure
vq2 = interp1(x,v,xq,'spline');
plot(x,v,'o',xq,vq2,':.');
xlim([0 2*pi]);
title('Spline Interpolation');

%% Convolution Review

x = randn(100,1)
figure 
plot(x)


kernelLength = 7;
kernel = ones(kernelLength,1)./kernelLength;
smoothedX = conv(x,kernel, 'valid');
xAxis = (((kernelLength-1)/2)+1):length(x)-((kernelLength-1)/2)


figure
subplot(2,1,1)
plot(x)
subplot(2,1,2)
plot(xAxis,smoothedX)

% Always gets you the correct xAxis for convolved data
(((kernelLength-1)/2)+1):length(x)-((kernelLength-1)/2)




%% Correlation

X = randn(100,10);
corr(X)


X = randn(100,1);
Y = X.*.8 + randn(100,1);


figure
scatter(X,Y)
[B,BINT,R,RINT,STATS] = regress(Y,[ones(length(X),1) X])










