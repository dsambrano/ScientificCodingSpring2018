%This script demonstrates how PCA works
%First with random data, then with actual data
%Illustrated with the case of spike sorting.
%Your name
%04/17/2018 - my 40th birthday!

%% 0 Init (brain being born, speaking of birthdays)
clear all
close all
clc
nn = 500; %Let's say we want to look at 500 points

%% 1 We will first use PCA to "remove" correlations
%That's a good way of thinking about it under the hood.
%The way PCA works/amounts to is that is detects/utilizes the correlation
%structure in the dataset and "removes" them by removing redundancies. 
%So let's create some variables, some correlated and some uncorrelated ones
%In the interest of time, this won't be the most elegant code

A = normrnd(0,1,nn,2); %Draw 2 uncorrelated variables from random normal distributions

%PCA works *best* if the underlying distributions *are* normal. If they are
%not, ICA might be your friend. And others. There are literally ~20 of
%them.

%Let's make correlated ones from these
B(:,1) = normrnd(0,1,nn,1); %We could use one of the As, but let's make a new one, just for the hell of it
B(:,2) = B(:,1) + 0.5 + 0.5 * normrnd (0,1,nn,1); %Correlated, but not completely

%Take half of the old values and half of the new ones, which should keep
%variability the same. 

%Let's visualize this
figure
subplot(1,2,1)
scatter(A(:,1),A(:,2))
axis square
subplot(1,2,2)
scatter(B(:,1),B(:,2))
axis square
shg

%PCA feeds on correlation. If there is no correlation, there is nothing to
%latch on to.

%As you can see there is redundancy in the right pot. How can we extract
%and remove this redundancy algorithmically. 
%How about we do the PCA. STEP by STEP. You will only ever do this once. 

%%
%Step 1: Calculate the covariance matrix (it's a bit silly here, because we
%have only 2 variables. But this generalizes to n variables)
covA = cov(A)
covB = cov(B)

%If we *only* wanted to do the PCA, we could now throw out the underlying
%data and use only the covariance matrices - they contain all the
%information we need (Of course, never throw data away in real life). 
%All future steps are based on these covariance matrices

% Step 2: Get the eigenvectors and eigenvalues from the convariance
% matrices (Eve and Eva)

[V_a, D_a] = eig(covA); %The eig function gets the eigenvectors (V_a) and eigenvalues of the covariance matrix
[V_b, D_b] = eig(covB); %Same for B

%To see what is going on, let's plot this
figure
subplot(1,2,1)
plot(A(:,1),A(:,2),'.','color','k')
hold on
line([0 V_a(1,1)],[0 V_a(2,1)],'color','b')
line([0 V_a(1,2)],[0 V_a(2,2)],'color','r')
axis square
axis equal
subplot(1,2,2)
plot(B(:,1),B(:,2),'.','color','k')
hold on
line([0 V_b(1,1)],[0 V_b(2,1)],'color','b')
line([0 V_b(1,2)],[0 V_b(2,2)],'color','r')
axis square
axis equal
shg
%We really should scale these vectors by their length (the eigenvalues).
%But have no time for that here

%Eig recovered 2 eigenvectors because we gave it 2 variables.
%If we had given it 20 variables, it would have given us 20 eigenvectors
%(and eigenvalues)

%This is a pathological case, so we'll skip extracting the number and
%naming them. But we can still do the last step, which is actually
%interesting, which is expressing the original data in terms of the new -
%rotated - coordinate system. 

%So let's do the rotation
%a)
V2_b = fliplr(V_b); %Put the eigenvectors in the right order (from higher to lower)
%b) Do the actual rotation. How do we rotate a vector? A vector corresponds
%to matrix multiplication with an orthogonal matrix. Take math tools if you
%want to know more.
newB = B*V2_b; %This is not element-wise. It's a matrix multiplication = it rotates

%Let's see if it worked. Unrotated on left, rotated on right
figure
subplot(1,2,1)
plot(B(:,1),B(:,2),'.')
axis square
axis equal
subplot(1,2,2)
plot(newB(:,1),newB(:,2),'.')
axis square
axis equal
shg


%% I have good news for you. Now that we did this once step by step, just to understand
%what is going on, we (I) will never do this again. Luckily for you, there
%is a MATLAB function that literally does this all in one step
[eigVec, rotVal, eigVal] = pca(B); %That's it. All in one go. Like the shampoo. It's now already in the right order

%Check if it worked
figure
plot(rotVal(:,1),rotVal(:,2),'.')
axis equal
axis square
shg

%Degenerate scree plot
figure
bar(1:2,eigVal)

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
figure
for ii = 1:1000
plot(waveforms(:,ii),'color','k') %Looking at them one by one
shg
pause(0.01)
end

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

%%
[eigVecs, rotVals, eigVals] = pca(waveforms);

% It looks like it worked. 
% BUT if we put in 48 time measurements, we'll get 48 factors out. If the
% point of the exercise is to reduce dimensions, we just failed completely.
% We need to make a decision how many of them are real. Let's do a Scree
% plot
%%
x = 1:length(eigVals); %x Base
figure
bar(x,eigVals)
line([0 49], [1 1])

% 4 seem to be real. But to plot 4, I would need to make a movie and we
% have only 10 minutes left. So let's do 3. 

%To now inspect the 48 dimensional waveforms (each waveform lives or is
%defined in a 48 dimensional space. But the dimensions are not independent.
%Voltages in neighboring time points are likely to be similar. We
%capitalized on that to plot these waveforms in a low-dimensional (3D
%space). 
%To illustrate this, we need to plot the rotated values
%%
figure
plot3(rotVals(:,1),rotVals(:,2),rotVals(:,3),'.','color','k')
axis square
axis equal