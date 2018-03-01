%First thing: Write a header
%In this session, we will cover all skills needed to implement the Posner
%paradigm. If you can do this, you can start working in any attention lab
%today. We'll also introduce our last data type: Structures. And delve
%deeper into randomness. 
%Who did this?
%How can I reach them?
%When? 

%% 0 Init
clear all
close all 
clc 

%% 1 Structures
%They are a great type for storing data. Why? Because they have "field
%labels". You don't have to remember which column represents what. 
%(This is particularly critical for scientific computing, because in our
%field, the numbers usually represent something. In Math, the numbers stand
%for themselves)

%Analogy: Biology. 
%DNA: Structures - storage unit for the genetic code
%RNA: Matrices - what makes the actual proteins

%I advise a similar approach: Store data in structures, do computations in
%copied matrices. It's a hybrid approach. Technically, you don't have to do
%this. You can get away without using structures or you could use only
%structures. 

%Let's declare one
participants = struct(); 
%The pictogram of a structure in the workspace is a tree, one the side. 
%This is important to note. Structures are inherently nested or
%hierarchical. So you can represent data from complex experiments
%efficiently. Today, we'll probably only use 1 or 2 hierarchy levels
participants(1).Name = 'Helena';
participants(2).Name = 'Christina'; 
participants(3).Name = 'Dan'; 

%This creates the first field, "Name". The parantheses after the structure
%name tells you which entry you want to modify. 
%The field name is accessed by a dot, because it is an object.

participants(1).Condition = 'A';
participants(2).Condition = 'B';
participants(3).Condition = 'AB';

%A big advantage of structures is that you can mix and match whatever you
%want: Numbers, strings, dates, and other matrices. Or even other
%structures. Cell arrays, whatever you want. 
%Think of it as a big container with many differently shaped and labeled
%compartments. 
participants(1).Age = 22;
participants(2).Age = 23;
participants(3).Age = 19;

participants(1).DATA = [12 30 20 15];
participants(2).DATA = [5 7 10 11];
participants(3).DATA = [12 nan 20 15];

%So much for 1 level structures. You can have as many fields and levels as
%you want. Let's add one. I leave the rest as an exercise to the reader
participants(1).DATA2.cond1 = [12 20];
participants(2).DATA2.cond1 = [5 7];
participants(3).DATA2.cond1 = [90 78];
participants(1).DATA2.cond2 = [17 25];
participants(2).DATA2.cond2 = [6 8];
participants(3).DATA2.cond2 = [50 13];

%The advantage of this is that you can represent the logical structure of
%your experiment in this way. Some conditions are nested, some measures are
%repeated, etc. It's best to bake this into the logical structure of the
%data. Instead of keeping track of this later (in a flat matrix)

%In general (and this can be proved mathematically) there is a tradeoff
%between structures (how data is represented) and processes (operations on
%data). What can be be proved is that it doesn't matter. You can compute
%anything either way. But not all representations are equally efficient.
%I'm going to teach a good balance (I hope). 

%If this is arcane, don't panic. We'll get used to all of this over time. 

%% 2 Non-text stimulus presentation 
%Next week: Free form stimulus generation of sights and sounds!
%Today, we'll lean on pre-existing objects in MATLAB to make graphical
%stimuli. Between this and last week, that's enough to recreate basically
%all cognitive psych experiments from the 1980s. 

f1 = figure %Open a new figure and call it f1

%To make the posner stimuli, we need to be able to show squares, which are
%specialized rectangles. We need 4 numbers to represent any rectangle. In
%photoshop, it is the 2 opposing vertices (x and y), in Matlab it is the
%lower left starting position (x and y), plus width, plus height. 
h1 = rectangle('Position',[5 0.7 28 2])
xlim([0 100])
ylim([0 100])
h2 = rectangle('Position',[0 20 5 40])
h3 = rectangle('Position',[87 42 25 15])
h4 = rectangle('Position',[50 50 49 49])

%The rectangle object is very versatile. In addition to a position, it also
%has a "curvature" property. In combination, you can make most shapes you
%want just with the rectangle object. For instance, "curvature" shows how
%beveled the edges are
h4.Curvature = [0.5 0.5]
axis square %Makes the aspect ratio the same
axis equal  %Makes the unit size the same. We don't have to do this because we specificed equal x and y limits, but this is the general way to do it


%% Transforming a rectangle into a circle (going through ellipsoids)
stepSize = 0.01;  %The smaller the smoother
f2 = figure;
axis equal
axis square
xlim([0 100])
ylim([0 100]) %If you don't do this, in this order, the aspect ratio will be off

h1 = rectangle('Position',[25 25 50 50])
h1.FaceColor = [1 0 0]; %Red
h1.LineWidth = 5; %Make thicker edges
h1.EdgeColor = [1 1 0]; %Yellow glow
for ii = 0:stepSize:1
    h1.Curvature = [ii]; %Case sensitive
    title(['Curvature = ', num2str(ii)]) %A complex title. Titles have to be strings. If I want to use numbers as part of the title, I have to convert them first
    
    pause(0.1)
    shg
end

%% 3 Making the rectangle flash at a given time
f3 = figure; %Open a new figure
h3 = rectangle('Position', [0.3 0.6 0.3 0.3])
xlim([0 1])
ylim([0 1])
h3.EdgeColor = 'w'; %Lets make it invisible to begin with
h4 = rectangle('Position', [0.4 0.7 0.1 0.1])
h4.EdgeColor = 'w'; %Lets make it invisible to begin with

shg
%I want to make it flash after 2 seconds of figure onset
pause(2)
h3.FaceColor = [0 0 1]; %Blue
h4.FaceColor = [1 0 1]; %Purple
h4.EdgeColor = [1 0 1]; %Purple
pause(0.1) %Good flash time
h3.FaceColor = [1 1 1]; %Make it white again
h4.FaceColor = [1 1 1]; %Make it white again
h4.EdgeColor = [1 1 1]; %Make it white again   

%Now we have the basic capabilities to do stimulus generation and
%presentation of graphics objects. But there are a lot of nuances to make
%it work properly

%% For instance: if this was an experiment like posner, should the onset of
%the flash always be the same? Probably not. We could specify an array of
%possible onset times. We could also randomize it

f4 = figure; %Open a new figure

for ii = 1:100
h5 = rectangle('Position', [0.3 0.6 0.3 0.3])
xlim([0 1])
ylim([0 1])
h5.EdgeColor = 'w'; %Lets make it invisible to begin with


shg
%I want to make it flash after 2 seconds of figure onset
scaleFactor = 3; %Maximal wait time is 3 seconds
pauseTime = rand(1) * scaleFactor %Rand draws from 0 to 1, uniformly 
pause(pauseTime)
h5.FaceColor = [0 0 1]; %Blue
pause(0.1) %Good flash time
h5.FaceColor = [1 1 1]; %Make it white again
end

%% 5 MOMA: Descent into complete randomness
f5 = figure; 
for ii = 1:1000 %We could make this random too, or just make it an infinite loop, with while
    h6 = rectangle('Position',[rand(1,4)]); %We want it to come up at a random position
    xlim([0 2]) %To accommodate all posible rectangles
    ylim([0 2]) %To accommodate all posible rectangles
    h6.Visible = 'off'% Let's make it invisible to begin with
    h6.Curvature = rand(1,1); %Random beveling
    shg
    pauseTime = rand(1)*0.5; %Fast
    pause(pauseTime) %Flash onset after this
    h6.EdgeColor = rand(1,3);
    h6.LineWidth = rand(1)*10;
    h6.FaceColor = rand(1,3);    
    set(gcf,'color',rand(1,3))
    set(gca,'color',rand(1,3))
    axis off
    h6.Visible = 'on'; %Make it visible
    pause(rand(1)*0.2)
    h6.Visible = 'off'; %Back to invisible
end

%% 6 As we lean heavily on randomness, this is a good step to discuss random numbers. 
%Lots of things can go wrong. 

%First question: Are the numbers coming out of the rng (random number
%generator) in MATLAB actually random? 
%Actually, no. The numbers are 100% deterministic. They just look random to
%you. This is called "pseudorandom". To get actual random numbers, you will
%have to hook Matlab up to a hardware random number generator. 
%The trickiness: Because we're not going to do that, but use MATLABs random
%number generator, we have to be careful. Because the numbers are
%pseudorandom.

%I will teach an old way (that always works) and a new way (that is much
%better, but doesn't work for everyone). Because the rng is an object now

%RNG seeds the random number generator to a number. This controls how all random functions work.
%Randi, rand, randn, randperm, and so on. 
%For instance

rand(1,5)

rng(1234)
rand(1,5)

%Whether you want to seed the random number generator to something known or
%not is up to you. But every time you use the same seed, you will get the
%same numbers. Instead of storing random images, for instance. You could
%just store the seed you used to generate them.

%Here is how a seed works: Think of a very large number. Like a mersenne
%prime. Think about pi. How many digits of pi are there. Lots of them. Are
%the consecutive numbers in the list deterministic or random? Both. 
pi
%Imagine you had all the digits of pi. To get a sequence of effectively
%random numbers (but that are 100% deterministic), all you need is the
%starting point. That is what a seed is. Instead of pi, we use a Mersenne
%prime, but it is the same principle. 

%Here is how you can go wrong. Say you want to randomize the order of
%trials for each participant. You expect 1,000 participants. You want to
%store the seed. What most people do is to hook this up to the system
%clock. If you read any computer science book, that's what they recommend. 
%However, this is tricky in practice
%Many people use something like this
seedNumber = round(sum(clock)) %Clock gets the system time in seconds, but it is a vector. 
%We want a single number. So we need to sum it. And it expects integer, so
%we need to round.
%The problem with this: There are only about 120 unique numbers you can
%get.
%If you have 1000 participants, some of them will share sequences. 

%Since we are talking about dates anyway, let's do something cool.
%In excel, day 1 is January 1st, 1900. 
%In some applications, day is January 1st, 1980. 
%In MATLAB, day 1 is January 1st, year 0. But there are
%issues. I thought Jesus Christ was born on 12/24, also is there a year 0?
%Years are like MATLAB, there is no 0. Python starts with 0. 
%To get a sense of this, use the now function, now is a number.
datestr(359+365);

%The solution is to either hook up the seed to the participant number -
%assuming that each participant has a unique number, or increase the
%granularity of the clock, something like that;
temp = clock.*1e6;
seedNumber = round(sum(temp)); 
rng(seedNumber)