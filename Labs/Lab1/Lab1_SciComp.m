%% -------------------------Lab 1: Calculations, basic syntax, variables, data structures-------------------------
% Scientific Computing for the Behavioral Sciences - Spring 2017
% Prof. Pascal Wallisch
% TA: Deshawn Sambrano

% Topics:
% help and doc
% input, operations, output 
% syntax, numbers, variables, vectors and matrices (data structures),
% indexing (discretizing), matrix arithemetic, finding indices and elements.
% operations.


%% --------------------------------------------Introduction-------------------------------------------
%We need to understand different ways that
% the computer represents data and how we are able to access it and operate on it
% in the most efficient way possible.

%% -------------------------------------Functions/Operations of the Week----------------------------------
% close all; clear all; clc
% +, -, /, *, ^,(./, .*, .^), sqrt, sin, cos, exp, log, ',=,==,<,>.
% help, doc, save, min, max, length, size, who, whos, find
% plot (google: learn by looking).
% Also: pi, i, j and making sure you don't use variables that are already
% defined in MATLAB.


%% Probleme 1
% Add two numbers:

...(replace with answer)

%% Probleme 2
% Assign a number to a variable 'a':

...(replace with your code)
    
%% Probleme 3
% Add two digits and assign to 'a':

...(replace with your code)
    
%% Probleme 4
% Subtract two digits and assign to 'b':

...(replace with your code)

%% Probleme 5
% Multiply two digits and assign to 'c':

...(replace with your code)

%% Probleme 6
% Divide two digits and assign to 'd':

...(replace with your code)

%% Probleme 7
% Calculate the sum of a, b, c, and d and assign to e (in one expression):

...(replace with your code)

%% Probleme 8
% Calculate the sum of a and b, multiply that by the difference of c and d, then divide that whole quantity by e. Assign all of this to f (in one expression):

...(replace with your code)
    
%% Probleme 8
% Close all figures, delete your whole work space, and clear your command
% window:

...(replace with your code)
    
%% Probleme 9
% Create a row vector called 'A' with the first 5 digits in order:

...(replace with your code)
    
%% Probleme 10
% Create a column vector called 'B' with the first 5 digits in order (two ways of doing this):

...(replace with your code)
    
%% Probleme 11
% Multiply A and B elementwise. What happens? Why?

...(replace with your code)
    
%% Probleme 12
% Change vector A to a column vector and reassign it to itself:

...(replace with your code)
    
%% Probleme 13
% Multiply A and B elementwise and assign to 'C':

...(replace with your code)

%% Probleme 14
% Apply a common mathematical operation to C that will "turn it back" to looking like A and B. Assign it to 'D':

...(replace with your code)
    
%%  Probleme 15
% Clear your workspace again as you did in Probleme 8:

...(replace with your code)
    
%% Probleme 16
% Create a vector containing numbers 1 to 10 without typing out 10 numbers:

...(replace with your code)

%%  Probleme 17
% Create a vector containing your date of birth such that DOB = [M M D D Y Y Y Y]:

...(replace with your code)

%%  Probleme 18
% Using DOB, write an expression (replacing the []'s) that will parse out the information:

month = []
day = []
year = []

%%  Probleme 19
% Without recreating DOB, change the year you were born to the
% year your father was born:

...(replace with your code)

%%  Probleme 20
% Now, change the day you were born to the day your mother was born:

...(replace with your code)
    
%%  Probleme 21
% Now, change the month to the month your father was born:

...(replace with your code)
    
%%  Probleme 22
% Create a vector containing 1000 evenly spaced numbers between 0 and 2pi
% and assign it to the variable 'myRadians' .
% (hint: for the discretization argument, use an arithemetic expression):

...(replace with your code)

%%  Probleme 23
% Make two new vectors, x and y, containing the cosine and sine of
% myRadians. Then, plot(x,y) .

...(replace with your code)

%% Probleme 24
% Create a 3X3 matrix containing 9 distinct digits. Call it myMat.

...(replace with your code)

%% Probleme 25
% Transpose the myMat matrix and call it myTrans:

...(replace with your code)

%% Probleme 26
% Add these matrices and call it 'theForest':

...(replace with your code)
    
%% Probleme 27
% In the second row of theForest, pull out the elements in the second and third columns and call it
% 'G'. Look at theForest and verify that this is correct.
    
...(replace with your code)
    
%% Probleme 28
% Assign the number 2 to the variable 'whereAm_i':

...(replace with your code)

%% Probleme 29
% Now find the indices of any numbers in 'theForest' equal to whereAm_i and assign them to [imInThisRow imInThisColumn]  :

...(replace with your code)

%% Probleme 30
% Using the row and column saved in the variables [imInThisRow
% imInThisColumn], output the element we were looking for and assign it to the variable
% 'iAmHere':

...(replace with your code)

