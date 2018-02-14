%% -------------------------Lab 2: Plotting and Handling Random-ness-------------------------
% Scientific Computing for the Behavioral Sciences - Spring 2018
% Prof. Pascal Wallisch
% TA: Deshawn Sambrano

%% -------------------------------------Functions/Operations of the Week----------------------------------
% plot, hist, histogram, and bar
% rand functions



%% Probleme 1
% Close, clear, and clean.

close all; clear all; clc

%% Probleme 2
% Create the domain for a function, x, as integer values from 0 to 10 with 1000 steps. "Soft code" it so that it
% can be easily changed in the future.

plotStart = 0; 
plotEnd = 10; 
steps = 1000; 
x = linspace(plotStart,plotEnd,steps);

    
%% Probleme 3
% In 4 subplots, plot sin, cos, the exponential function and the natural
% log. Also,
% (a) Plot each with a different color.
% (b) Give each a title and label the axes: domain and range.
% (c) For sin and cos, set ylim to -+ .2 of  the min and max of the
% function's range.
% (d) Add the commands: axis square, box off (for each subplot).

ySin = sin(x);
yCos = cos(x);
yExp = exp(x);
yLn = log(x); 

figure('units','normalized','outerposition',[0 0 1 1],'Color',[1 1 1]) % This makes it full screen and white background.
subplot(2,2,1);  % tell it which subplot you want to work on. 
h1 = plot(x,ySin);  
set(h1,'Color',[rand(1,3)]) % This sets the color to. Specifcally it picks 3 numbers at random between 0 and 1 to set the color. Try running rand(1,3) to see
ylim([min(ySin) - .2,max(ySin) + .2]) % Ensures the plot does not go all the way up to the edge of the graph. 
title('sin(x)'); 
xlabel('domain'); 
ylabel('range'); 
axis square; 
box off;

subplot(2,2,2); 
h2 = plot(x,yCos); 
set(h2,'Color',[rand(1,3)])
ylim([min(yCos)-.2 max(yCos)+.2])
title('cos(x)'); 
xlabel('domain'); 
ylabel('range'); 
axis square; 
box off


subplot(2,2,3);
h3 = plot(x,yExp); 
set(h3,'Color',[rand(1,3)])
title('e^x'); 
xlabel('domain'); 
ylabel('range'); 
axis square; 
box off


subplot(2,2,4); 
h4 = plot(x,yLn); 
set(h4,'Color',[rand(1,3)])
title('ln(x)'); 
xlabel('domain'); 
ylabel('range'); 
axis square; 
box off



%% Probleme 4
% Exploring randomness: rand([r c]),  randn([r c]), randi(5,[sampleSize 1]),
% randperm(N) , randsample([0 1],N,true,[.8 .2]).

% (a) Assign 10^6 to a variable sampleSize:

sampleSize = 10^6;

% (b) Using rand, create a random column vector with r=sampleSize rows (suppress
% output with ;). Plot these values in a histogram. Based on this, what
% numbers would you say the rand function samples from and with what
% distribution?

p = rand([sampleSize 1]);
figure % Let's create a new figure if not it will keep overridding your previous subplot
subplot(1,3,1)
hist(p)

% (c) Replicate question (b) with the function randn([r c]). Answer the same question.

p2 = randn([sampleSize 1]);
subplot(1,3,2)
hist(p2)


% (d) Change sampleSize = 5*10^3. Using randi, create a vector of length sample size from number upto
% n = 5. Output all the number 2's generated into a variable called twos.
% Find the size of twos and divide that number by 5*10^3.

sampleSize = 5*10^3;
p = randi(5,[sampleSize 1])
length(find(p==2))/(5*10^3)

% (e) Figure out what the function randperm(N) does by trying various values of
% N:

% ANSWER: It randomly shuffles the order of numbers 1:N. help randperm for
% more argument options.

% (f) Using randsample, create a vector with N=100 numbers full of 0's (with p=.8
% of occuring) and 1's (with p=.2 of occuring). Find the location of the
% zeros and ones using the find() function and find the frequencies using
% length(). Put these frequencies/100 into one vector called freqs and plot a
% bar().

N = 100;
p = randsample([0 1],N,true,[.8 .2]); % For those who are ambitious, who can think of a way to do this same thing using rand and find?
freqs = [length(find(p==0))/N length(find(p==1))/N]
subplot(1,3,3)
bar(freqs)







