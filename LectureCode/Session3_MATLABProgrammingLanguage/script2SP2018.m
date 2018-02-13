%Header
%This is the 2nd script of the course. 
%So far, we just used scripts as code repositories. We could have typed
%everything in the command line. We just put it in a script so we can run
%it again without typing it again. 
%Now, we will use/introduce scripts as a genuine programming language.
%Specifically, we will control the program flow with loops and switches. 
%Loop: Run the same commands over and over again, with slight
%modifications. SERIAL. One after the other. 
%Switches: Conditionals. Do things if some conditions are true, other
%things if others are. PARALLEL. 
%Dependencies: None
%Who wrote this? 
%When? 
%How can I reach them? 

%% 0 Init: 2 steps: Start from a blank slate, then repopulate with priors
clear all %Clear memory (if anything is in it)
close all %Close all figures (if any are open)
clc %Clear screen - if it's not already clear

%Priors, assumptions and modifiers
startLoop = 5; %This is the index with which we want our loop to start 
endLoop = 11; %This is the index with which we want our loop to end

%% 1a) An example of a loop: For loops
%Some DNA codes for proteins (the genes). Other DNA just switches the genes
%on and off. Code is a lot like that. 
%In MATLAB, instructions for the computer to do something are in black. 
%Instructions that modify how the code itself is executed are in blue. 
%These are (few!) keywords reserved for this purpose. Do NOT overwrite them

%A counter or tally
%Syntax:
%for a set of values (usually a vector) of numbers, do all the instructions
%between the "for" and the "end" statement

for ii = 1:10 %NEVER use just i or j if you don't want to look like a noob
    ii
end
    
%1b) A counter that is not hardcoded and doesn't use ii
for jj = startLoop:endLoop %More flexible
    jj; %It still counts to the end, but doesn't output it because we put the echo off
end

%1c) The vecotr we use for indexing doesn't have to be consecutive
%and the variables don't have to be ii and jj
indexVector = [3 12 -1 5 pi]; %Not consecutive and not all positive
for fangfang = indexVector %Go through all elements in the indexVector and assign them to fangfang
    %The value is changed every time we go through the loop. Assuming the
    %values in indexVector, from first to last, one by one. Until the end
    %of the vector is reached.
    fangfang %To be clear: The indices of the indexvector have to be integers, but the values do not have to be
    %Indices: Number of elements in the indexvector. Location of the
    %element in the vector
    %Values: Their corresponding value. The element itself. 
end

%1d So far, we basically only introduced the notation of a loop. Let's make
%a loop that does something useful. For instance, a running tally
%A cumulative sum
indexVector = startLoop:endLoop;
 
tally = 0; %Initialize tally as 0. We need to do this because we have to start counting somewhere. 
%One of the most common logical mistakes is to put this initialization in
%the wrong place. 
for ii = indexVector %State here what changes loop by loop
    tally = tally + ii %Add up all the values in the index vector
end

%Matlab (and programming languages in general) cannot discern intent. They
%just do literally whatever you tell it to do, even if it is dumb. 
%Where to put the initialization is kind of obvious if you one loop. But if
%you multiple ("nested") loops, things can get tricky quickly. And it
%really matters where you put them. 
%Insiduously, MATLAB will not throw an error if you make a logical mistake.
%In other words, you made a mistake without knowing that you did. Which is
%probably the worst kind of mistake. 

%The issue is one of machine to human translation. MATLAB does what you ask
%it to do, but that might not be what you thought you were asking it to do.
%

%1e) Illustrating the power of loops
indexVector = 1:1e6; %What is the cumulative sum of 1 to a million? 
tally = 0; %Again, to zero, before the loop
for ii = indexVector %We want to keep track of the cumulative sum
tally = tally + ii %Simply add the value of the indexvector to the tally
end

%A very gaussian result. But let's mix switches into the loop. For
%instance, what if we only want to see the final result, or the result
%after adding up a thousand or something like that.
%Think of a switch as a fork in the road. Usually do x, but sometimes do y.

%% 2a Switches, with Copy and paste of the last loop code
indexVector = 1:1e6; %What is the cumulative sum of 1 to a million? 
tally = 0; %Again, to zero, before the loop
tallyIterationIWantToKnow = 500; %Andy's choice
for ii = indexVector %We want to keep track of the cumulative sum
    tally = tally + ii; %Echo on, so we don't see all of them
    if ii == tallyIterationIWantToKnow %If (and only if!) the two numbers are equal
        tally %Output the tally at that point in the loop
    end
end %For every if or for you open, you need to close it with an end
%The 2nd most common logical mistake is to put the end in the wrong place
%Unlike in python, indentation is meaningless. But recommended, use "smart"
%indent. It makes the code more readable, particularly if you have a lot of
%loops. 

%Like loops, an if statement executes all the code between if and end, but
%only if the conditions in the conditional are met

%% 2b a loop with more than one true switching statement. Copy the whole code
%again, but with more than one true statement
indexVector = 1:1e6; %What is the cumulative sum of 1 to a million? 
tally = 0; %Again, to zero, before the loop
tallyCutoff = 1000; %Tallies below this cutoff, we want to see
for ii = indexVector %We want to keep track of the cumulative sum
    tally = tally + ii; %Echo on, so we don't see all of them
    if ii < tallyCutoff %If (and only if!) the two numbers are equal
        tally %Output the tally at that point in the loop
    end
end %For every if or for you open, you need to close it with an end

%% 2c) Code within an if statement lies dormant unless the conditions are met.
%Then it is executed. Let's use this insight to make something useful. 
%Now: A switch that does something useful
raffle = randi(10,1); %Draw a random integer from 1 to 10 from a uniform distribution
%randi takes two arguments: 1): The max number, 2) How many numbers
if raffle == 10
    disp('You are a winner!')
elseif raffle == 9
    disp('Close, but not quite')
elseif raffle == 1
    disp('Loser')
else
    disp('Too bad')
end
raffle %Manipulation check

%Any if statement is only executed once. In order: This checks whether the
%value is 10. If it is 10, execute, and end. If not, it checks if it is 9,
%then if if it is 1, and if it is none of that, it outputs what is under
%else.

%% 3 There is another kind of loop we must talk about.
%So far, we have only done for loops. A fundamental limitation of the for
%loop is that we have to know how many times we want to loop (or iterate). 
%The 2nd kind of loop is called a "while" loop. Idea: Execute the loop
%until a stopping condition is met, then stop. For instance, run it until
%you win the raffle. Run the experiment until the participant has a certain
%level of performance. 
%Let's repurpose and modify our raffle code

raffle = 0; %Initialize it first. Otherwise we never ever even go into the while loops
numTries = 1; %We want to keep track how long it took. Initialize this outside
%While while loops are flexible, they are also very tricky. The first try
%is try number 1; 
%while raffle ~= 10 %Run this only if raffle is not 10 - we use to run until we win
while raffle < 11 %This will always be true
raffle = randi(10,1); %Draw a random integer from 1 to 10 from a uniform distribution
%randi takes two arguments: 1): The max number, 2) How many numbers
if raffle == 10
    disp('You are a winner!')
    numTries %Output it here, when we win
    raffle
elseif raffle == 9
    disp('Close, but not quite')
elseif raffle == 1
    disp('Loser')
else
    disp('Too bad')
end
    
    %Terrorist prevention mechanism
    if numTries >= 1e3 %If we encounter 1000 tries, we think something fishy is going on. 
        %Maybe someone hijacked our code. We need to break.
        numTries
        disp('Something weird happened. Terminating execution of program!')
        break; %Terrorist prevention mechanism kicks in. Stops execution of the loop.
    end %Ending of runaway code check 

    %Get used to incrementing at the end
        raffle; %Manipulation check
    numTries = numTries + 1; %Outside of the if statement, but inside the loop. To count all iterations

    
end %This ends the while loop

%% Introducing nested loops - what makes loops really useful (but complicated)
%Say you have reaction time dat for a number of participants and trials
%We want to add up all the times PER PARTICIPANT (to see if some people are
%slower than other)
%Also across trials (to see if some trials are harder than others)
numParticipants = 200; %Well powered
numTrials = 30; %Let them work for they pay
totalTime = 0; %We want to know how long it took them, but we need to initialize it
counter = 0; %To make sure we counted everyone
DURATIONBUCKET = nan(numParticipants,1); %Initialize as nan, so we presume that all data is missing
%Let's create the SATA
reactionTimes = rand(numParticipants,numTrials);
stimulusOnset = 0.2; %When the stimulus came on
%To do what we stated in our mission statement, we need 2 loops, one within
%the other. One: Go through all trials per participant, one, go through all
%participants

numTrials2 = 1:30; %Maria's suggestion. That would work
%When writing nested loops, I strongly advise to start with the innermost
%one, then "code out".
for pp = 1:numParticipants %Outer loop
    
durationPerPerson = 0; %Initialize here, so we start with a new time PER PARTICIPANT

for tt = 1:numTrials %This just needs to be a set of values that we index through. Just don't hardcode them
    durationPerPerson = durationPerPerson + reactionTimes(pp,tt); %Add the pp, tt'h reactiontime to the duration per person
end

%Capturing the duration: Outside of the inner loop, but inside of the outer
%loop, importantly, AFTER the inner loop.
DURATIONBUCKET(pp,1) = durationPerPerson;
end

%This loop does only half of what it is supposed to do. It gives us the
%time per participant. But not the time per trial.
%In the interest of time, modifying these loops to do both is left as an
%exercise for the coder. (Do this in lab)
%Caroline's concern is still valid: We failed completely. This is not the
%reaction time. We need to subtract the stimulus onset time. At the right
%point in the loops. Also do this in lab. 

%% 5 String handling
%Matlab (and every other programming language) handles strings
%fundamentally different than numbers. They dont (easily) mix. 

%To declare a string, use single scare quotes
name1 = 'betty';
name2 = 'becky'; 

name1(4)
name2(4)

%To compare strings (whether they are the same), you can use the function
%"strcmp". Since Matlab 2017x, you can also simply ask for equality

%Element by element: 
name1 == name2

%Whole
strcmp(name1,name2) %Should be 0 (they are not the same)
strcmp(name1,'betty') %Should be 1 (they are the same)

%Strcmp returns 1 if all the elements of the two strings are the same,
%otherwise 0

nameToUse = name2 
%Application: Check whether a name is already sorted alphabetically
temp = strcmp(nameToUse,sort(nameToUse))
if temp == 1
    disp([nameToUse, ' is inherently sorted alphabetically'])
else 
disp([nameToUse, ' is not inherently sorted alphabetically'])  
end

%Say you want to store a bunch of names, we can't use a matrix. 
%This is where "cell arrays" come in.
%A vector is a stack of numbers
%A matrix is a stack of vectors
%A cell is a stack of of matrices

%The reason we need this is that matrices have to have the same of elements
%Cells do not. So they are very flexible
%To access (reach into) a cell, we introduce the last type of parantheses
%we use in this class and in Matlab. "Curly braces"
%{ } above the square brackets

Names{1,1} = name1;
Names{2,1} = name2; 
%This creates a single cell that contains all the names
%First row is name 1, second row is name 2

%So to access the 3rd element of the first name, letter "c",
%we need to concatenate the statements.
Names{1}(3)