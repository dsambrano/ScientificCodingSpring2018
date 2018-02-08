% Everything to the right of a percentage sign is a comment. It is ignored
% by MATLAB and rendered in greed (by default)

%I highly recommend getting into the habit of commenting profusely. 
%For beginners, I recommend the following policy: 
%1) Write a header paragraph at the beginning of the file outlining what
%the program does, what assumption it makes, what inputs it takes, what
%outputs it makes, who made it, when (version history) and how to get a
%hold of them if there are questions. 
%2) Write another paragraph what a code *section* is supposed to do (the
%strategic goal)
%3) Writing in line (at the end of each line little pointers explaining
%literally what the line does)


%Let's start over. If this was a real file: Header
%This file represents our first script. For now, we just use it as a
%repository for commands. We could have typed everything here in the
%command line. This particular script will focus on introducing graphing
%and plotting functionality. 
%Dependencies and assumptions: None
%Version history: V1 - 02/06/2018: The initial program
%Who did this (your name) and your email


%% (double percentages without space) indicate a code section 
%This is auto-bolded. It allows you to organize your code into logical
%segments that you can execute at once. This is highly recommended.
%Sections are executed by command (on mac) or Ctrl (on pc) and enter at the
%same time. 

%% 0 Initialization (wiping the memory (if you want to) and initialize parameters

%Wiping - starting from a blank slate
clear all %This command clears the workspace (memory)
close all %This closes all open figures
clc %Clears the screen

%Choices, parameters and constants that modify the execution of the script
startPlot = 0; %This is where we start to plot
stepSize = 0.1; %This is the granularity of our plotting
endPlot = 4*pi; %End of plot
lineThickness = 2; %Line thickness
nyuPurple = [87 6 140]./255; %NYU purple
fS = 14; %Our default fontsize
fN = 'Arial'; %our default font name
%% 1 Basic plotting
figure %Opens a new figure. If you don't specify this, it will open one for you, but it is wise to make it explicit
x = startPlot:stepSize:endPlot; %x-variable
y = sin(x); %Taking the sine of x
h = plot(x,y) %Plotting y against x and assigning it to handle "h"
shg %Show graph. Some versions of Matlab auto-shg. I make it explicit
xlabel('time in seconds') %Adding an x-label
ylabel('voltage in microVolt') %Adding a y-label
title('Voltage over time') %Adding a title

%% 2 Taking full control of the figure appearance by getting a handle on things

%a) Line thickness
set(h,'linewidth',lineThickness)

%If you are unsure of what properties you can modify, use the "get"
%function and feed it the figure or axes handle

%b) Line color
set(h,'Color','k') %Making the line black
%There are 8 predefined colors, such as black, green, blue and so on. 
%Not NYU purple and not pink. 
%So you can also use RGB values, which we will provide as a vector
%Since Matlab 2014b, you can also set the properties of your handle in a
%different way, without using set. It's object-oriented . notation
h.Color = nyuPurple; %Setting the color method of the h object to nyu Purple

%c) Other stuff
xlim([startPlot endPlot]) %Now our plotting limits are the same as the data limits
deanLine = line([startPlot endPlot],[0 0]) %Adding a zero line
deanLine.Color = 'k' %Black
deanLine.LineStyle = '--' %Dashed line

%d) This figure violates all of Tufte's commandments. Let's fix some of
%them
box off %Take off meaningless lines that box in the figure
set(gca, 'tickdir', 'out') %Using the "gca" which is the 'get current axes' command instead of an explicit axes handle
set(gca, 'FontSize', fS)
set(gca, 'fontName', fN)
set(gca, 'fontAngle', 'italic')


%% 3 Adding a 2nd line to the plot (the plot thickens)
z = cos(x); %Cosine

%In order to *add* this line to the existing plot, we literally need to
%hold on
hold on %This sets the hold on
lizMorganHandle = plot(x,z) %Plotting z vs. x, with new object handle
shg %Show graph again
lizMorganHandle.Color = 'k' %Make it black
lizMorganHandle.LineWidth = lineThickness %Make it thick

%We now named our object handle something memorable, instead of just "h" or
%- what I've seen "h1", "h2" and so on. Usually, you will have more than 16
%handles. So make it memorable. Again. Literally whatever you want. 
legend([h, lizMorganHandle], 'Condition 1', ...
    'Condition 2','Location', 'SouthEastOutside')

set(gcf,'color','w') %Make the figure white. gcf: Get current figure

%% 4 Multi-panel figures - instead of plotting 2 lines in one figure (which looks crowded, we now put them into subpanels)
newFigure = figure %We now assign a figure handle. In general, assign a handle to anything you want to have a handle on
%set(newFigure,'Position', [400 500 50 50]) Commenting out a line
subplot(2,1,1) %Open a subplot (think panel) in an arrangement of 2 rows, 1 column, then open the first one
hSine = plot(x,y) %Put the sine here
%Adding markers
set(hSine,'Marker','*') %Putting stars on
set(hSine,'MarkerEdgeColor', nyuPurple) %Make it purple
set(hSine,'MarkerSize',10) %Change size
subplot(2,1,2) %Open the 2nd subplot
hCos = plot(x,z) %Put the cosine here
hCos.Marker = 'diamond'
hCos.MarkerFaceColor = 'y'
hCos.MarkerEdgeColor = 'k'

%% 5 Indexing and laying out subplots (panels)
figure
subplot(2,3,1) 
plot(x,x)
title('1')
subplot(2,3,2) 
plot(x,y)
title('2')
subplot(2,3,3) 
plot(x,z)
title('3')
subplot(2,3,4) 
plot(y,z)
title('4')
subplot(2,3,5) 
plot3(x,y,z)
title('5')
subplot(2,3,6) 
plot3(x,x,y)
title('6')

%% 6 Histograms! (Counts per bin of continuous data. They touch)
SATA = randn(1e6,1); %Draw randomly, a million times from a normal distribution
nBins = 100; %Make it reasonable, given how many samples we have
figure 
subplot(1,2,1)
hist(SATA, nBins) %This makes a histogram. But it is the old way. the hist function has been with us for decades. It sucks. But it will always work
subplot(1,2,2)
histogram(SATA, nBins) %Also makes a histogram. With a new and much improved function. But not all of you will have it

%% 7 Bars and errors
numCond = 4; %Number of conditions
x = 1:numCond; %x base
y = 1:numCond; %Mean response
z = ones(1,4).*0.75; %Error - something reasonable 

figure
subplot(1,2,1) %Here, we put the bar graphs - they don't touch. Categorical
morgan = bar(x,y)
set(morgan,'FaceColor', [0.85 0.85 0.85]) %A light shade of gray

subplot(1,2,2) %Same bars, but with error bars
morgan = bar(x,y)
set(morgan,'FaceColor', [0.85 0.85 0.85]) %A light shade of gray
hold on %If we don't hold on, the error bars will overwrite the bars
ebar = errorbar(x,y,z)
set(ebar,'linestyle','none')
set(ebar,'color','r')
set(ebar,'linewidth',1)









