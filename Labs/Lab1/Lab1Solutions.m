%% -------------------------Lab 1: Calculations, basic syntax, variables, data structures-------------------------
% Scientific Computing for the Behavioral Sciences - Spring 2018
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

% Always start with these
close all
cleal all
clc

%% Probleme 1
% Add two numbers:

2 + 5

%% Probleme 2
% Assign a number to a variable 'a' and make sure to evaluate. If you don't
% evaluate a command, the computer doesn't know about it!

a = 4    
    
%% Probleme 3
% Add two digits and assign to 'a'. Once you do this, the variable you
% previously put in 'a' is erased and replaced by the new number.

a = 2 + 2
    
%% Probleme 4
% Subtract two digits and assign to 'b':

b = 4 - 1    

%% Probleme 5
% Multiply two digits and assign to 'c':

c = 2 * 3    

%% Probleme 6
% Divide two digits and assign to 'd':

d = 9/3

%% Probleme 7
% Calculate the sum of a, b, c, and d and assign to e (in one expression):

e = a + b + c + d

%% Probleme 8
% Making use of parentheses, calculate the sum of a and b, multiply that by the difference of c and d, then divide 
% that whole quantity by e. Assign all of this to f (in one expression):

f = ((a + b) * (c - d))/e

%% Probleme 8
% Close all figures, delete your whole work space, and clear your command
% window:

close all; clear all; clc % Notice we can string together these commands

%% Probleme 9
% Create a row vector called 'A' with the first 5 digits in order:

A = [1 2 3 4 5]

%% Probleme 10
% Create a column vector called 'B' with the first 5 digits in order (two ways of doing this):

B = [1; 2; 3; 4; 5] %first way
B = [1 2 3 4 5]' % second way

%% Probleme 11
% Multiply A and B element-wise. What happens? Why?

A .* B % We get an error "matrix dimensions must agree" because we can't multiply a row with a column.

%% Probleme 12
% Change vector A to a column vector and reassign it to itself:

A = A'

%% Probleme 13
% Multiply A and B elementwise and assign to 'C':

C = A .* B

%% Probleme 14
% Apply a common mathematical operation to C that will "turn it back" to looking like A and B. Assign it to 'D':

D = sqrt(C)    

%%  Probleme 15
% Clear your workspace again as you did in Probleme 8:

clear all; close all; clc    

%% Probleme 16
% Create a vector, called someNums, containing numbers 1 to 10 without typing out 10 numbers:

someNums = 1:10


%%  Probleme 17
% Create a vector containing your date of birth such that DOB = [M M D D Y Y Y Y] (all numbers spaced):

DOB = [0 2 0 6 1 9 9 4]

%%  Probleme 18
% Using DOB, write an expression (replacing the []'s) that will parse out the following information:

month = DOB(1,1:2)
day = DOB(1,3:4)
year = DOB(1,5:8)

%%  Probleme 19
% Without recreating DOB, change the year you were born to the
% year your father was born:
DOB(1,5:8) = [1 9 7 6]

%%  Probleme 20
% Now, change the day you were born to the day your mother was born:

DOB(1,3:4) = [2 9]   

%%  Probleme 21
% Now, change the month to the month your father was born:

DOB(1,1:2) = [1 1]    

%%  Probleme 22
% Create a vector containing 1000 evenly spaced numbers between 0 and 2pi
% and assign it to the variable 'myRadians' .
% (hint: for the discretization argument, use an arithemetic expression).
% Also, double-check the number of elements in the vector myRadians - it
% should be 1000.

myRadians = 0:((2*pi)/999):2*pi % First way: I had to calculate the step size
myRadians = linspace(0,2*pi, 1000) % Much easier way

%%  Probleme 23
% Make two new vectors called x and y containing the cosine and sine of
% myRadians, respectively. Then, plot(x,y) and add the command: axis equal

x = cos(myRadians)
y = sin(myRadians)
plot(x,y)
axis equal

%% Probleme 24
% Create a 3X3 matrix containing 9 distinct digits. Call it myMat.

myMat = [1 2 3; 4 5 6; 7 8 9]

%% Probleme 25
% Transpose the myMat matrix and call it myTrans:

myTrans = myMat'

%% Probleme 26
% Add these matrices and call it 'theForest':

theForest = myMat + myTrans

%% Probleme 27
% In the second row of theForest, pull out the elements in the second and third columns and call it
% 'G'. Look at theForest and verify that this is correct.
    
G = theForest(2,2:3)    

%% Probleme 28
% Assign the number 2 to the variable 'whereAm_i':

whereAm_i = 2

%% Probleme 29
% Now find the indices (location) of any numbers in 'theForest' equal to whereAm_i and assign them to [lookInThisRow lookInThisColumn]  :

[lookInThisRow lookInThisColumn] = find(theForest == whereAm_i )

%% Probleme 30
% Using the row and column saved in the variables [lookInThisRow lookInThisColumn],
% output the element we were looking for and assign it to the variable
% 'iAmHere':

iAmHere = theForest(lookInThisRow,lookInThisColumn)


