%This program performs a time series analysis on real data
%from the quantatitive diary of a patient diagnosed with bipolar disorder
%over the course of a year. 
%Your name
%Your contact information
%When? 

%% 0 Init
clear all
close all
clc

%% 1 Loader (transducer)
%The patient used excel to record the data. 
%So you need to convert the data from excel format to matlab format
%To do anything useful with it.
%So we need to get this from xls format into MATLAB
data = xlsread('timeseriesQuantitativeDiary.xlsx');

%To figure out what the columns represent, we need to recover the header
%By default, xlsread only recovers numerical data. So let's now use a
%function that recovers all the data
[numData, textData, rawData] = xlsread('timeseriesQuantitativeDiary.xlsx')

%header information is in the first row of the the rawData
headerInfo = rawData(1,:)

%Just a smidgen of notation on dates - because it is so complicated
%The timebase of excel (where this data is from): Day 1 = January 1st, 1900
%Matlab: Day 1 = January 1, year 0.
%So to make a good plot with meaningful time axis, you need to convert
%this.
%Two steps: 
%1) We need to find out what January 1st 1900 is in Matlab format.
%What number that is
offSet = datenum('01-Jan-1900')-2 %fencepost plus leap year;
%2) Add that number to the existing number
numData(:,9) = numData(:,1)+offSet

%Now we have a decent time base in Matlab, in the 9th column
%And now, we can explore the data

%% 2 Handle missing data, filter, Thamalus
%Luckily for you, this patient was diligent. There is no missing data
%in this time series. If there was, you need to impute

%% 3 Exploratory data analysis
%Looking at the raw data. This step is absolutely critical. 
%In this day and age, many labs skip this step. Because they want to cut
%corners. This step will not show up in the paper. 
%But do not cut it out. You and your PI MUST look at the raw, unprocessed
%data.
%Why? Because people are great at recognizing visual patterns but a
%processed dataset can hide many problems, just like processed food.
%It becomes deleterious to human health. 

%Let's say we want to know how the person slept over the year
%This is where your clinical domain knowledge comes into play.
%We know from the literature that sleep behavior is a leading indicator
%of mood. So let's look at that first
figure
plot(numData(:,9),numData(:,2))

%Looking at this time series, we note two things:
%1) It is very variable, so we will have to smooth it to detect episodes
%Obviously, the variability itself is a sign of the bipolar nature of the 
%patient, but we already know that. We just need to know when the episodes
%happen. 
deshawnOffset = 1; %Make this 0 if you believe that January 1st is day 0.
%2) The x-axis is hard to interpret. We'll have to do something about that
%The easiest thing to do would be to put it in terms of days of the year
numData(:,10) = numData(:,9)-min(numData(:,9))+deshawnOffset %Subtracting the smallest value
%If you believe that January 1st, is day 0, don't add 1. If you believe it
%is day 1, add 1. 

%Lets plot the raw data vs. the smoothed data.
subplot(2,1,1)
plot(numData(:,10),numData(:,2),'linewidth',2) %Plotting the unsmoothed data
title('unsmoothed')
xlim([0 366])

%To smooth, we need a kernel. This is where you domain knowledge of being a
%human being comes in. What makes sense? Living in this reality, on a rock
%floating around a heated gas sphere. 

kernelLength =  21; %A meaningful integration window
kernel = ones(kernelLength,1); %The shape of the kernel is also up to you.
%Here, an equal weight kernel is fine. But these choices have dramatic
%consequences, as we will see next week, in frequency space. 
%So choose wisely.
kernelWeight = sum(kernel); %Keep track of this because you need 
smoothedSleep = conv(numData(:,2),kernel,'valid')./kernelLength;
subplot(2,1,2)
plot(smoothedSleep,'linewidth',2)
title(['smoothed sleep time series with kernel of length ', num2str(kernelLength)])
xlim([0 366])

%By visual inspection, we suspect that there will be 3 manic and 2
%depressive episodes, but to confirm, we will need to validate this by
%looking at mood and energy during that period. 

%The longer your kernel is, the better your estimate of the points in it
%(on average), but you lose resolution (literally days), so every practical
%kernel you use will have to be informed by domain knowledge. In this case
%how long episodes usually last and cultural knowledge about what a week
%is. 

%% Look at mood vs. sleep
figure
plot(numData(:,2),'color','b')
hold on
plot(numData(:,3),'color','r')

%In principle, this is the raw data, but there are 2 problems:
%a) Mood data and sleep data are on different scales
%b) Variability obscures what is really going on --> Smoothing

figure
plot(smoothedSleep,'color','b')
hold on
smoothedMood = conv(numData(:,3),kernel,'valid')./kernelLength;
plot(smoothedMood,'color','r')
xlim([0 366])

%Now it is smoothed, but we still need to address the scale issue
%Easiest way: A double-y axis
figure
x = 1:length(smoothedSleep);
h = plotyy(x,smoothedSleep,x,smoothedMood)

%Other solution: Use several subplots - lesson for the reader.
%Discouraged because journals are moving away from single line subplots

%"Best" - or most common solution is Morgan's solution: Normalization.
%z-scoring. Subtracting the mean and dividing by the standard deviation.
%This yields scores in units of SD, from 0. 
normalizedSleep = normalizer(smoothedSleep);
normalizedMood = normalizer(smoothedMood); 

figure
plot(normalizedSleep,'color','b','linewidth',3)
hold on
plot(normalizedMood,'color','r','linewidth',3)

%We made a function that zscores

%So far, we only look at the means over time. 
%That's literally - at best - only half the story. 
%The other part - particularly for the bipolar person - is variability
%We also need to represent variability in the same graph. 
%To do that, we will utilize what is called a "shaded patch". 
%Because plotting 360 error bars will be busy. 

%Patches are a little idiosyncratic in Matlab. But they can be done.
%You can't do this in SPSS, Excel, etc.
%So we need to work up to this, how patches are represented in the first
%place
%%
%Step 1: We will fill a triangle to understand how this works. In brief, we
%need to give vectors that define all vertices, plus close. 
X = [0 1 0.5 0];
Y = [0 0 1 0];
C = 'r';
figure
h = fill(X,Y,C)

%To hammer down the logic, let's make a square
X2 = [0 1 1 0 0];
Y2 = [0 0 1 1 0];
C2 = 'b';
h2 = fill(X2,Y2,C2)
xlim([-1 2])
ylim([-1 2])
%%
%Now we know how fill and patch works in principle. How do we apply this to
%our time course?
%First, we need to sweep across x, adding the negative y lobe, then sweep
%back and add the plus y-lobe. 
x = 1:length(normalizedSleep); %This is the x-basis
tempX = fliplr(x); %This goes in the other direction
combinedX = [x tempX]; %Go to the right, then back to the left
SEM = ones(length(normalizedSleep),1); %In the interest of time, but really: STD / sqrt(n)
minusY = normalizedSleep-SEM;
plusY = flipud(normalizedSleep+SEM); 
bothY = [minusY; plusY]
figure
h = fill(combinedX,bothY,[0.7 0.7 0.7])
hold on
plot(x,normalizedSleep,'color','k','linewidth',3)
set(h,'FaceAlpha',0.5) %1 = opaque, less: You can see both

%To get real SEM, we have to do the following: 
%STD of normalized sleep will be one over the whole sequence.
%To get localized SEM (for a given bin), we need to write a function
%MOVING (or windowed) STD, then divide by the number of values in the bin.
%Number of values going in: Kernel length
%Homework: Ask Deshawn in the lab. Make a moving STD function.
