% Filters and Frequency Space
    % Who 
    % When and Contact
    % Version

%% 0 Init
clear all
close all
clc


%% 3 Continued from Lecture
fs = 1000;
figure
wind = chebwin(256);
overl1 = length(wind)-1;
fPoints = 0:10:500;
t = 0:1/fs:2;
yChrp = chirp(t,100,1,200,'quadratic');
sound(yChrp,fs)
subplot(2,1,1)
plot(t,yChrp)
subplot(2,1,2)
spectrogram(yChrp,wind,overl1,fPoints,fs,'yaxis')


%% 4 Continued from Lecture


order = 5
[B,A] = butter(order, .6, 'low')
[B2,A2] = butter(order, .6, 'high')
[B3,A3] = cheby1(order, 5, .6, 'low')
[B4,A4] = cheby1(order, 5, .6, 'high')

fvtool(B,A)
fvtool(B2,A2)
fvtool(B3,A3)


%% 5 Again Continued from the Lecture Code

yLow = filtfilt(B3,A3,yChrp)
yHigh = filtfilt(B4,A4,yChrp)
yBand = filtfilt(B3,A3,yHigh)

figure
subplot(4,1,1)
spectrogram(yChrp,wind,overl1, fPoints,fs,'yaxis')
subplot(4,1,2)
spectrogram(yLow,wind,overl1, fPoints,fs,'yaxis')
subplot(4,1,3)
spectrogram(yHigh,wind,overl1, fPoints,fs,'yaxis')
subplot(4,1,4)
spectrogram(yBand,wind,overl1, fPoints,fs,'yaxis')

sound(yChrp,fs)
pause
sound(yLow,fs)
pause
sound(yHigh,fs)
pause
sound(yBand,fs)


