%% This script will recover some of the material from 3-20-18 Lecture
% Specifically, we will recover ANOVA and TTests


%% Init0
clear all
close 
clc

%% 1 Load the data

M1 = xlsread('MATRIX1.xls')
M2 = xlsread('MATRIX2.xls')
M3 = xlsread('MATRIX3.xls')

%% 2 Pruning: Getting rid of bad data

% We are going to use listwise deletions

M1nan = isnan(M1);
sum(M1nan)
M2nan = isnan(M2);
sum(M2nan)
M3nan = isnan(M3);
sum(M3nan)

validTrials = find(M1nan + M2nan + M3nan == 0);


% Get a sense of what is happening, this is element wise deletion
figure
bar([nanmean(M1) nanmean(M2) nanmean(M3)])


[H,P,CI,STATS] = ttest(M1(validTrials), M2(validTrials))
[H,P,CI,STATS] = ttest(M2(validTrials), M3(validTrials))


% Now let's do list wise
bar([mean(M1(validTrials)) mean(M2(validTrials)) mean(M3(validTrials))])



% ANOVA
[P,ANOVATAB] = anova1([M1(validTrials), M2(validTrials), M3(validTrials)])

