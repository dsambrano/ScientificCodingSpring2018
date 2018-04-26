%% Lab 12 Resampling methods
    % This will be fun
    % Who, when, contact
    % ETC
    
% 2 tailed permuation 
% 1 line bootstraping function
    
%% Init 0
clear all
close all
clc

%% 1 Bootstrap 1 line function  

% Example:
% Compute the confidence interval for the capability index in
% statistical process control:
y = normrnd(1,1,30,1);                  % simulated process data
LSL = -3;  USL = 3;                     % process specifications
capable = @(x) (USL-LSL)./(6* std(x));  % process capability
bootci(2000,capable, y)                 % Bca confidence interval
bootci(2000,{capable, y},'type','per')  % basic percentile method



%% Replicate example for class with the one liner function. 

nL = 11037;
nLS = 104;
nP = 11034;
nPS = 189;

nSamples = 1e4;


L1 = ones(nLS,1);
L2 = zeros(nL - nLS, 1);

W1 = ones(nPS,1);
W2 = zeros(nP - nPS, 1);

L = [L1;L2];
W = [W1;W2];


S = [L;W];
T = [ones(size(L)); zeros(size(W))];
data = [S,T];


ratio = @(X) sum(X(find(X(:,2) == 1),1))./sum(X(find(X(:,2) == 0),1));

bootci(4, ratio, data)


%% Permutation Tests (2 tailed)
K = [117 123 111 170 121];
C = [98 104 106 120 88];


numMCS = 1e4;

nK = length(K);
nC = length(C);

testStatistic = sum(K) - sum(C)


dTS = nan(numMCS,1);


allData = [K C];

for i = 1:numMCS
    tempIndices = randperm(nK+nC);
    tempDATA = allData(tempIndices);
    virtualGroup1 = tempDATA(1:nK);
    tempDATA(:,1:nK) = []; 
    virtualGroup2 = tempDATA;
    dTS(i) = sum(virtualGroup1) - sum(virtualGroup2);
end
%%
exactP = (sum(dTS>=testStatistic) + sum(dTS<=-testStatistic))./length(dTS);
CRLI = ceil(length(dTS) *.025);
CRUI = length(dTS) - CRLI;
sorteddTS = sort(dTS);
CRL =  sorteddTS(CRLI);
CRU =  sorteddTS(CRUI);



figure
histogram(dTS)
line([CRL CRL], [min(ylim) max(ylim)], 'color', 'r', 'linewidth', .5)
line([CRU CRU], [min(ylim) max(ylim)], 'color', 'r', 'linewidth', .5)
line([testStatistic testStatistic], [min(ylim) max(ylim)], 'color', 'k', 'linewidth', 3)
title(['Distribution of test statistic. Exact p = ', num2str(exactP,'%1.3f')])