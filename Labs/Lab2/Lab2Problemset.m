%% -------------------------Lab 2: Plotting & Randomness-------------------------
% Scientific Computing for the Behavioral Sciences - Spring 2018
% Prof. Pascal Wallisch
% TA: Deshawn Sambrano

%% -------------------------------------Functions/Operations of the Week----------------------------------
% plot, hist, histogram, and bar
% random-ness: rand([r c]),  randn([r c]), randi(n,[dims]), randperm(N) , randsample([random variable],N,true,[density]).

%% Probleme 1
% Close, clear, and clean.

...(replace with answer)


%% Probleme 2
% Create the domain for a function, x, as values from 0 to 10 with 1000 steps between. "Soft code" it so that it
% can be easily changed in the future.

...(replace with answer)

    
%% Probleme 3
% In four subplots (1 row, 4 columns) plot sin, cos, the exponential function and the natural
% log. Also,
% (a) Plot each with a different color.
% (b) Give each a title and label the axes: domain and range.
% (c) Set ylim to -+ 2 of  the min and max of the
% function's range.
% (d) Add the commands: axis square, box off (for each subplot).

...(replace with answer)


%% Probleme 4
% Esploring randomness: rand([r c]),  randn([r c]), randi(n,[dims]),
% randperm(N) , randsample([random variable],N,true,[density]).

% (a) Assign 10^6 to a variable sampleSize (supress output):

...(replace with answer)

% (b) Using rand, create a random column vector with r=sampleSize rows (suppress
% output). Plot these values in a histogram. Based on this, what
% numbers would you say the rand function samples from and with what
% distribution?

...(replace with answer)


% (c) Replicate question (b) with the function randn([r c]). Answer the same question.

...(replace with answer)


% (d) Change sampleSize = 5*10^3. Using randi, create a vector of length sampleSize for numbers upto
% n=5. Output all the number 2's generated into a variable called twos.
% Find the size of twos and divide that number by 5*10^3.

...(replace with answer)


% (e) Figure out what the function randperm(N) does by trying various values of
% N. What does it do?

...(replace with answer)


% (f) Using randsample, create a vector with N=100 numbers full of 0's (with p=.8
% of occuring) and 1's (with p=.2 of occuring). Find the location of the
% zeros and ones using the find() function and find the frequencies using
% length(). Put these frequencies/100 into one vector called freqs and plot a
% bar().

...(replace with answer)






