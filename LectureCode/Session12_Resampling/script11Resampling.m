%Script 11. Resampling methods: Bootstrap (with replacement) and
%permutation tests (without replacement)
%Apologies: There are an infinite number of ways to implement this
%Uncountably
%Your name
%04/24/2018

%% 0 Init
clear all
close all
clc

%% 1 Classic Efron (literally page 1 of his book "the bootstrap")
nL = 11037; %Number of lithium treated households
nLS = 104; %Number of suicides in lithium treated households
nP = 11034; %Placebo treated households
nPS = 189; %Number of suicides in place treated households
nSamples = 1e4; %Make this number big, but because we're teaching, it can't be too big
simRatio = zeros(nSamples,1); %Initialize the variable in which we will store the simulated ratios

%We will now recreate the data from the summary statistics. To use resampling methods you either
%have to have access to the raw data (particularly for permutation tests)
%or you have to recreate them. Summary statistics are not enough. 

L1 = ones(nLS,1); %Suicide vector under lithium 
L2 = zeros(nL-nLS,1); %Everyone else with lithium
W1 = ones(nPS,1); %Suicide vector under water
W2 = zeros(nP-nPS,1); %Rest. No suicide with water only

%Make the source data vectors
L = [L1;L2]; %Glued together (vertical stack)
W = [W1;W2]; %Same thing 

%We use 0 and 1 to represent these events. You can use whatever you want.
%In this (the simplest case) these are binary events. 

%Now the actual work can begin. What do we do?
%We resample from these. There are so many ways of doing this. 
%There are Matlab functions to do this. Let's not use them. Because I want
%you to understand what is happening. 
%Importantly, we will sample with replacement. Why and what does this mean?
%Throwing them back into the original basket (sample). This will allow us
%to get a representative estimate of the variability of sample means.

%So we use the original data twice, once to get the mean AND to get the
%variability. This seems like cheating, but it works. 
%To be clear, we need to find new indices and take the means, then divide
%them
%So let's do that. 

%% 2 Let's just do it. Resample

for ii = 1:nSamples %Resample nSamples times with replacement
    indicesL = randi(length(L), [length(L), 1]); %Each time we do this, the resampled sample needs to be the *same* size as the original sample
    %If we sampled without replacement, this would be dumb, because it
    %would be the exact same thing. But it isn't. 
    %The unique number of indices is much smaller than the total number
    %temp = unique(indicesL); size(temp)
    %We are sampling from our actual sample, so this is an unbiased
    %estimator of what is actually going on. Equal chance. Equal
    %opportunity. 
    indicesW = randi(length(W), [length(W), 1]); %Same thing mutatis mutandis for water only
    simRatio(ii) = sum(L(indicesL))/sum(W(indicesW)); %Take the ratio of suicides in each group for a given resampled sample and note it in the ratio array
    
end

%% 3 Let's find the CI. The 95% one for now, let's do 50% and 99% in the lab. 
%step by step
%a) Sort the values. This is a necessary preliminary step
sortedRatio = sort(simRatio); %Make a copy of the ratio array and sort it.
%b) Cut off the tails
confidence = 95; %This is a common value
%Identify the indices of the lower and higher bound we care about
lowerBoundIndex = round(nSamples/100*((100-confidence)/2)); %Divide by 2 because it is 2-tailed. Round because the are indices
upperBoundIndex = round(nSamples/100*(50+(confidence/2))); %This should work

lowerBoundValue = sortedRatio(lowerBoundIndex); %Find the actual lower bound value
upperBoundValue = sortedRatio(upperBoundIndex); %Find the actual higher bound value

%% 4 Let's find out if this worked by plotting it
ratio = nLS/nPS; 
figure
histogram(simRatio,100); %100 bins
xlabel('Ratio')
line([ratio ratio], [min(ylim) max(ylim)], 'color','r')
shg
line([lowerBoundValue lowerBoundValue],[min(ylim) max(ylim)],'color','k')
line([upperBoundValue upperBoundValue],[min(ylim) max(ylim)],'color','k')
%This seems to work, broadly speaking, but there is an offset somewhere

%Exercise for the lab: Use adventurous underlying distributions, play
%around with different CIs, figure out how to do this in one line. 

%% 5 The only other thing you really need to know (everything else is a variation of the two basic methods)
%is the permutation test. That's sampling without replacement. 
%Basically rearranging the chairs on the Titanic. Why would you ever want
%to do that? 
%I'll use the simplest possible case. 
%Remember: We stress out the rat. These are called "Monte Carlo
%Simulations" (MCS) in the language of the art.

K = [117 123 111 170 121]; %Dendritic spines of our 5 Ketamine treated neurons
C = [98 104 106 9 88]; %Control group - untreated

numMCS = 1e4; %A reasonable number of simulations 
nK = length(K); %Number of neurons in the experimental group (same as original)
nC = length(C); %Number of neurons in the control group 

%This right here is now the one creative step. Which has thus far prevented
%mass adoption of permutation tests.

testStatistic = sum(K) - sum(C); %This is reasonable

%YOU have to decide on a reasonable test statistic and you have to justify
%it to the reviewers. You want to take the sum, the means, the squared
%deviations, the ratios, the differences. Depending on the theoretical
%question and the nature of the data. All of those and mixes of them might
%make sense. Take the log first. As long as you can defend it, it's legit. 
%For teaching purposes [lab: Try a different version and see if it
%matters]: The simplest one, difference of sums. For instance, if the
%groups were not equal n, the sum would make no sense, we would have to
%take the mean. If we were working with ratios, we would have to divide,
%not subtract. 
%Logic for sum difference: If Ketamine is effective to grow dendritic
%spines (spoiler, it is), there should be a large group difference. Large =
%more than you would expect by chance. Let's find out. 

dTS = zeros(numMCS,1); %Initialize the array that will hold the distribution of test statistics

%Idea: How likely is the empirical outcome just by chance? Say if Ketamine
%had no effect
%Steps, 1 by 1
%1 Glue them together
allData = [K C]; %Just glue our data vectors together. 
%2 We pretend we lost the labels
for ii = 1:numMCS
    %Instead of sampling with replacement, we now need to do this without
    %replacement. Permutations
    tempIndices = randperm(nK+nC); 
    %Rejigger the indices (SHUFFLE: Randomly reorder but keep everything)
    tempDATA = allData(tempIndices); %Create a new, permuted dataset
    virtualGroup1 = tempDATA(1:nK); %New, virtual treatment group
    tempDATA(:,1:nK) = []; %Simple delete them and keep the rest as the placebo group
    virtualGroup2 = tempDATA; %The control group is what is left
    dTS(ii) = sum(virtualGroup1)-sum(virtualGroup2); %Capture the simulated test statistic
    
end

%Let's do a one-tailed test first (it is easier): 2-tailed: lab
%For theoretical reasons, we only care if Ketamine works to grow. Not just
%if there is a mean difference
exactP = sum(dTS>=testStatistic)./length(dTS); %?

%% 6 Final step: Let's plot this
figure
histogram(dTS,50); %50 bins
%We now need to superimpose our empirical test statistic
line([testStatistic testStatistic],[min(ylim) max(ylim)],'color','k','linewidth',3)
title(['Distribution of test statistics. Exact p = ', num2str(exactP,'%1.3f')])
