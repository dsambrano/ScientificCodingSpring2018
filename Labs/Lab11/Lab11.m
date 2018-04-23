%% Lab 11 We will be focusing on dimension reduction and the key differences between PCA and FA
    % This will be fun
    % Who, when, contact
    % ETC
    
    
%% Init 0
clear all
close all
clc

%% Factor analysis

load carbig

% Define the variable matrix.
X = [Acceleration Displacement Horsepower MPG Weight]; 
X = X(all(~isnan(X),2),:);


% Estimate the factor loadings using a minimum mean squared error
% prediction for a factor analysis with two common factors.
[Lambda,Psi,T,stats,F] = factoran(X,2,'scores','regression');
inv(T'*T);   % Estimated correlation matrix of F, == eye(2)
Lambda*Lambda' + diag(Psi); % Estimated correlation matrix
Lambda*inv(T);   % Unrotate the loadings
F*T'; 


biplot(Lambda,'LineWidth',2,'MarkerSize',20)


%% Now that we did this with the toy example, let's see if this works for neural data
DATA = load('SPIKES.mat') %Loading the data. I already preprocessed it for you.

%The dataset is complex. It comes from an electrode array with multiple
%channels, recording sessions, etc. - to be clear: It is *real* data. For
%now, let's just extract the waveform (voltage trace over time)
waveforms = DATA.session(2).chan48.wf; %Lets' look at the waveforms from channel 48. 

%Each voltage trace consists of 48 measurements. Each time the voltag on
%the electrode tip crossed some threshold, we captured the 48 subsequent
%voltage snippets. In this recording session, this happened just over
%80,000 times. What we would like to know: How many neurons generated these
%waveforms? 
%We cannot do this by visual inspection. Let's try it

figure
plot(waveforms(:,1)) %Literally the first waveform
shg

%How about we plot a thousand?
% figure
% for ii = 1:1000
% plot(waveforms(:,ii),'color','k') %Looking at them one by one
% shg
% pause(0.01)
% end

%As we just established, visual inspection is hopeless. There might be
%anywhere from 1-3 neurons here that generated these waveforms. Maybe more?
%How would we know?

%Let's do a PCA. Importantly, PCA expects floating point numbers. They
%usually come out of the rig digitized to save space, so we have to convert
%them first:
waveforms = double(waveforms)'; 
mW = mean(waveforms(:)); %Linearize
sW = std(waveforms(:)); %Then subtract the mean and divide by standard deviation
waveforms = (waveforms-mW)./sW; %Makes the math work more nicely

%% FA vs PCA 
[Lambda,Psi,T,stats,F] = factoran(waveforms,3,'scores','regression');

[eigVecs, rotVals, eigVals] = pca(waveforms);


figure
plot3(F(:,1),F(:,2),F(:,3),'.','color','b')
axis square
% axis equal


figure
plot3(rotVals(:,1),rotVals(:,2),rotVals(:,3),'.','color','k')
axis square
axis equal


corr(F(:,1), rotVals(:,1))
corr(F(:,2), rotVals(:,2))
corr(F(:,3), rotVals(:,3))