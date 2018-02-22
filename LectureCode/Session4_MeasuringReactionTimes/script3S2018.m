%In this script, we will lay out the basic but critical skills to record
%behavioral data.
%Today, we'll focus on timing, capturing user input and creating text
%stimuli
%Who wrote this?
%How to reach them?
%02/20/2018

%% 0 Init
clear all
close all
clc

%% 1 Measuring time in Matlab
%There are many ways of doing this. As always. But as usual, we'll start
%with the simplest (and oldest!) one. This is the tic/toc combo.

tic
toc

%Tic/toc is a stopwatch. It measures the time from the instant tic was
%called to the instant toc was called. If toc is called is called again, it
%is the cumulative time since the last time tic was called.

tic %Starts the timer afresh
toc
toc %Cumulative

%If there is nothing between tic and toc, it measures the time it takes
%matlab to read a line and execute a single command.

%% 2 Measuring the consistency of timing in MATLAB
%We need to make sure that MATLAB is fast and consistent enough for what
%you want to do. In neuroscience and psychology, that's about 1 ms.
%Let's now create a loop and go through the loop. We want to measure how
%long it takes to do that. And I want to illustrate the power of
%preallocation.
numRep = 1e6; %Number of repetitions
for ii = 1:numRep %Making one big loop. Warning. Executing this takes about 3 minutes
    tic
    A(ii,1) = ii; %Record the iteration
    A(ii,2) = toc; %Record the time it took to iterate in microseconds
end

%%
figure
histogram(A,100)

AinMicro = A;
AinMicro(:,2) = A(:,2) .* 1e6; %Putting it into microseconds

figure
plot(AinMicro(:,1),AinMicro(:,2))
shg

%If we don't preallocate, MATLAB creates the array on the fly, meaning that
%it adds a row at the end, each time. This means that the entire has to be
%recreated (and copied), which takes longer the bigger it is. Also,
%sometimes MATLAB needs to internally switch to another data type, which
%really takes a long time. So it takes too long and is inconsistent

%The solution is preallocation
%Because you are not re-creating the space a million times, making it
%bigger and bigger. You create it once, but switch elements. Which is very
%fast. In contrast, incrementing array size one by one is slow.

%One more thing about consistency: There will still be some inconsistency

%% 3 The effects of preallocation


numRep = 1e6; %Number of repetitions

A = zeros(numRep,2); %Initialize with zeros. There is a problem with this, which we will fix

for ii = 1:numRep %Making one big loop. Warning. Executing this no longer takes 3 minutes
    tic
    A(ii,1) = ii; %Record the iteration
    A(ii,2) = toc; %Record the time it took to iterate in microseconds
end

%We realized a speedup of about 1,000. --> Always preallocate if you can.

AinMicro = A;
AinMicro(:,2) = A(:,2) .* 1e6; %Putting it into microseconds

figure
plot(AinMicro(:,1),AinMicro(:,2))
shg

%The remaining inconsistency stems from what?
%Modern operating systems always have a lot going on. Lots of processes,
%lots of threads. Solution: If you run an experiment, restart the machine
%and run nothing but MATLAB. Don't use a browser, no internet, nothing
%else. All of that will make it more consistent.

%There is a tiny effect of commenting. If you run experimental code, don't
%comment it.

%% 4 Basic UI - we'll use timing functions to measure reactiong time
tic
%You can also add instructions:
disp('Press a key, any key')
pause %Press *any* button. Until a button is pressed, nothing will happen
rT = toc %Reaction time in seconds
%Make sure your focus is in the command line for this to work

%% 5 Using pause to structure program flow (on the stimulus side)
%We just used pause to get the reaction time of the user. But pause is
%versatile. We can also use it to structure presentation and execution
%times of the program. For instance, if we want to present a stimulus for
%200 ms, it is something like this:
pause(0.2)

%In general, in programming: Trust but verify. So let's measure it
for ii = 1:100
    tic
    pause(0.197) %We want it to wait for 200 ms. But de facto, it takes longer to execute
    B(ii,2) = toc; %If we are to measure toc, it needs to be as close to tic as possible
    B(ii,1) = ii;

    if mod(ii,10) == 0 %If we made this one, it would count 1, 11, 21, etc.
        ii %Instead of outputting every iteration, we want to only count every 10th one
    end
end

figure
histogram(B)
mean(B)
std(B)

%% 6 Actually getting user input
%Before, we kind of cheated. Pause simply pauses the program until someone
%pressed a button. It doesn't matter which button it is. It also doesn't
%record which button was pressed. So we now need to find a way to actually
%capture user input

%a) Straight up from the input function
tic
kP = input('Please press the k key ', 's') %Without the 's', this only accepts numbers
toc

%This captures the key, and it measures the time, but it waits for
% "carriage return". So this is actually more suitable for something like entering your name
tic
kP = input('Please enter your age in years ') %Without the 's', this only accepts numbers
toc

%% b) Key input without carriage return
%The last character (key) the user pressed is a figure property (!)
lascap = figure %Open a new figure, calling it lascap
pause %Wait for user input
%To retrieve the key the user pressed to move on, we type
userPressedKey = get(lascap,'CurrentCharacter')

%This also works (since Matlab 2015a)
lascap.CurrentCharacter

%The last character pressed is in this. The figure does not have to be
%visible for this. It just has to be open. 

%% Let's use this logic to make sure the participant pressed only valid keys
%Say we assign q for yes and p for no. 
validKeyPressed = 0; %Initialize this as zero
f6 = figure %Open a new figure
while validKeyPressed == 0 %Do this until this condition is no longer true
    disp ('Press q for yes, p for no, don''t press anything else ')
    pause
    userPressedKey = get(f6,'CurrentCharacter');
    if strcmp (userPressedKey,'q') == 1
        validKeyPressed = 1;
    elseif strcmp (userPressedKey,'p') == 1
        validKeyPressed = 1; 
    else
        disp('You pressed an invalid key, try again!') 
    end
end
userPressedKey

%For the assignment, you will need to distinguish 4 cases: Target present,
%user says it is there, target absent, user says it is not there and both mismatches. 
%If we have time, we'll do this later today, if not: Think about how you
%can do this with an if statement with 4 cases. 

%% 7 Stimulus presentation. 
%This is the last piece that you absolutely need, in order to do the
%homework. How do we actually generate our stimuli and present them? 
%Today: Stimuli as text arrays. We have to start somewhere. 

figure
maryTheObjectHandle = text(0.5,0.5,'Hello World!')
%This is our first text output, putting the text at position 0.5, 0.5 in
%coordinates from 0 to 1
maryTheObjectHandle.FontSize = 20; %Bigger, but not too big
maryTheObjectHandle.HorizontalAlignment = 'center'; %No longer left aligned
maryTheObjectHandle.Color = 'r'; %Something you might want to be able to do for the feature search assignment
maryTheObjectHandle.FontWeight = 'bold'; 

%Rafael wants the figure to be screensize and just white
screenSize = get(0,'ScreenSize'); %This is the size of our screen
set(gcf,'Position',screenSize)
set(gcf,'color','w')
axis off
set(gcf,'ToolBar','none')
set(gcf,'MenuBar','none')

%Let's say we want to create a stimulus display of 20 green o's at random
%positions on a black background
%%
figure
for ii = 1:10 %Do this 10 times. This is arbitrary. Just to show you delete and what happens if you don't use delete
numStim = 20; %We want to place 20 stimuli
stimToDisp = 'o'; %What we want to put 
stimPos = rand(numStim,2); %This gets us 20 random x and y coordinates
%Unless specified otherwise, your graph will go from 0 to 1, so using the
%rand function is adequate here. 
outPutDisplayHandle = text(stimPos(:,1),stimPos(:,2),stimToDisp) %This is an object handle!
axis off
set(outPutDisplayHandle, 'Fontsize', 20)
set(outPutDisplayHandle, 'color', 'g')
%Make the background black
set(gcf,'color','k')
set(outPutDisplayHandle,'Fontweight','bold')

%We now made the distracters. Let's add a target
%The target is a red x.
stimToDisp2 = 'x';
stimPos2 = rand(1,2) %Just one x and y position for our target

%If you are concerned about collision or occlusion, you can check whether
%they overlap. Basically go through all stimulus positions and check if
%they are too close to another one. If they are, redraw from rand. Do that
%- with a while loop - until there are no collisions. 

%No need to hold on for text. It's an annotation function. plot overwrites
%the existing graph. You need to hold on to add to it. text doesn't. 
targetHandle = text(stimPos2(:,1),stimPos2(:,2),stimToDisp2)
set(targetHandle,'color','r')
set(targetHandle,'FontSize',20)
set(targetHandle,'FontWeight','b')

%Because text doesn't hold off, you need to delete the handle at the end of
%each iteration. To do so, use the delete function. Be very careful when
%you use it because you could literally delete all the files on your
%computer. With one command.
shg
pause
delete(targetHandle)
delete(outPutDisplayHandle)

end

%% 8 How to randomize trials
%Here is my advice: 
%Create all trials ahead of time. In a big matrix.
%Randomly. Maybe make them while the participant fills in the demographic
%information. So that there is no time variability when you run it. 
%But this means you need to figure out the order in which you display these
%pre-made trials. 
%For instance, let's say you want to create 160 trials in blocks of 40. 
%Maybe create all of them as a matrix. But you need to decide the order of
%presentation by random shuffle. You don't just want to randomize, why not?
%You could say randi(160) - this draws randomly from 1 to 160, integers
%only. If we did that, some trials would be presented multiple times
%whereas others wouldn't be presented at all. We don't want to draw with
%replacement. We just want to shuffle. 
%Rearranging the order (shuffling) is drawing without replacement.
numTrials = 160
randperm(numTrials)

%Advice for HW:
%Create all the stimuli in blocks: All stimuli with a target, all without,
%all with one dimension, all with 2 dimensions (color and shape). But then put them all in a big matrix
%and access their number with the randomly permuted order. 

%Unicode: The reason this is flexible is because you can present almost
%anything like this. There is a unicode number for almost any symbol that
%is currently (or in the past!) in human use. Text takes char(n) inputs. 
