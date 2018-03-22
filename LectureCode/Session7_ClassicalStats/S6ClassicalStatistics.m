%This script implements a basic statistical analysis of a real dataset
%recorded by the instructor in the early 2000s. 
%We will practice the canonical data analysis cascade. 
%The data represent how much study participants liked the movies
%"Matrix I" to "Matrix III".
%Question: Are there significant differences in liking.
%Two possibilities: 
%Fans (the device) will like all of them equally. Or not. 
%Date
%Who wrote this and how to contact them 

%% 0 Init - we still initialize
clear all
close all
clc

%% 1 Loader (Transducer): Get the data into a matrix
%Data is on the website: MATRIX1-3.xls or M1-3.mat
%Two ways: With and without excel.
%a) With excel. If this works for you, go for it. 
M1 = xlsread('MATRIX1.xls');
M2 = xlsread('MATRIX2.xls');
M3 = xlsread('MATRIX3.xls');

%b) Without excel. (Not everyone has excel and Matlab doesn't always play
%nice with it)
load('M1.mat')
load('M2.mat')
load('M3.mat')

%% 2 "Thalamus" the data. In this dataset, the big challenge is to 
%handle missing data because not everyone has seen all of the movies. 
%So we need to prune those. 

%Special issue in this dataset: Is the missing data likely to be randomly
%missing of systematically missing?

%The missing data is likely to be missing systematically.
%In other words, someone who didn't like the first one, will probably 
%not see the other ones. So that will possibly skew the numbers.
%So we need to be careful how we get rid of missing data so that doesn't
%happen.
%There are 3 ways to handle the missing data:
%a) Element-wise removal of missing data: Get rid of data in each matrix
%that is missing, but not others.
%The simplest solution. 
%Problem 1: Resulting datasets will not be of equal size. 
%Problem 2: This will likely skew the mean of the 3rd one because people
%are probably less likely to see the 3rd one if they didn't like the first
%one

%There are many ways of doing *that*. nanmean, or eliminate missing rows or
%take non-missing rows and constitute a new matrix
M1clean = M1(isnan(M1) == 0); %Go into M1, find all existing values (that are not missing) and put them into a new one
M2clean = M2(isnan(M2) == 0); %Go into M1, find all existing values (that are not missing) and put them into a new one
M3clean = M3(isnan(M3) == 0); %Go into M1, find all existing values (that are not missing) and put them into a new one

%Maybe we should first look of how big of a problem this is 
%(Count the missing values per movie)
sum(isnan(M1))
sum(isnan(M2))
sum(isnan(M3))
%Conclusions: We should be concerned that this is a problem
%There is "experimental mortality" - a common problem in repeated measures
%designs. Say you have people come back for 10 weeks, they are not all
%going to come back. If you study diligence, that could be a problem.

%Which way to deal with missing data (element-wise) or participant-wise
%if *any* value is missing from a participant, we throw out the whole
%participant. 
%Biggest con: We're gonna lose a lot of data
%Biggest advantage: This is clean, this sets us up for a within subjects
%analysis 

RATINGS = [M1 M2 M3]; %Create one big matrix that contains all ratings
killSet = (sum(isnan(RATINGS'))' > 0); %This could also be done with a loop
keepSet = (sum(isnan(RATINGS'))' == 0);
RATINGS2 = RATINGS(keepSet,:); 
RATINGS(killSet,:) = []; %Eliminate everyone with at least 1 missing value

%Problem: We lost 2/3 of the dataset. This might hard to justify in a
%method section. People might get suspicious wheether this is
%representative.

listOfNans = find(isnan(RATINGS) == 0); 
%Convert them to row and column indices
[I,J] = ind2sub([1603,3],listOfNans);

%c) Imputation: Replacing missing values with what you think 
%they should be. Could simply be the mean, could be something from machine
%learning. Whatever. But it is a guess and this is why this method is
%frowned upon in science, where we are concerned with the truth.
%In industry/engineering, imputation is probably the most common way to
%handle missing data. Because the motto there is "whatever works". 

%Also, apart from the philosophical problems, imputation relies on
%assumptions. And they might not be true, so you might be wrong. 

%% 3 Formatting the data. 
%This time, there is not much to do because I already did this for you. 
%In complex data sets that come in as a function of time (all from now on)
%we will spend most of our time here. 
%Aka Data munging. Entire careers are spent doing this. 

%% 4 Analysis - let's do it for both cases
% I Element-wise first
%a) Descriptives: Summaries of the data
MEANS = [mean(M1clean) mean(M2clean) mean(M3clean)]
STDs = [std(M1clean) std(M2clean) std(M3clean)]
Ns = [length(M1clean) length(M2clean) length(M3clean)]
SEMS = STDs./sqrt(Ns);

%We see that there is an obvious drop in appraisal from 
%the 1st to the 2nd one, but it will require statistical tools
%to assess whether there is a reliable drop between 2nd and 3rd.

%b) Inferential statistics: ttest
%We'll have to do an independent samples ttest here
[sig, p, CI, APAparams] = ttest2(M1clean,M2clean, 'alpha', 0.05/3);
[Dean, Daniel, Rafael, Max] = ttest2(M2clean,M3clean,'alpha', 0.05/3); %The meaning of the output is determined by its order. We can call it whatever we want
[Alice, FangFang, Lisa, Nina] = ttest2(M1clean,M3clean,'alpha', 0.05/3);
[Vasily, Simone] = ttest2(M2clean,M3clean, 'alpha', 0.05/3)

%We have to correct for multiple comparisons, so we have to divide the
%alpha of 0.05 by 3. 

%c) Let's do an ANOVA instead. One-factor, 3 levels. 
%However, because we have unequal sample sizes, we can't put them all in a
%matrix, we have to declare a grouping vector.
G1 = ones(Ns(1),1); %Create a vector of 1060 1s. 
G2 = ones(Ns(2),1).*2; %Create a vector of 837 2s. 
G3 = ones(Ns(3),1).*3; %Create a vector of 770 3s. 
G = [G1; G2; G3]; %Vertical concatenation of grouping variable
V = [M1clean; M2clean; M3clean]; %Values, vertically concatenated
[p, antab, stats] = anova1(V,G)

% II row-wise (or list-wise or participants-wise)
mR = mean(RATINGS)
sR = std(RATINGS)
nR = length(RATINGS)
SEMR = sR./sqrt(nR)

%If anything, the other analysis (element-wise) was hiding the true
%magnitude of the falloff. The true fans forced themselves to watch all of
%them, hiding the pain of doing so. 

%Let's continue/finish with the inferential statistics for this 