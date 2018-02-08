%1  Numbers and arithmetic operations
2 + 3
7 - 3
7 + 2 - 3
5*5
24 / 7
24/8
2 +                       8
2 + + 8
2 + - 8
2 + 3 * 5
(2 + 3) * 5
2^10

%2	Exploring the limits of number space
1e9
1e-9
10^100
2^100
2^1000
2^10000
2^1024
2^1023
2^1023*2
2^1023*1.999999999999999
2^1024/1000
2^-1074
2^-1075
-2^1023
-2^1024
-2^-1074
-2^-1075
inf*0

%3 	Introducing formatting 
log(2.7138)
format short
log(2.7138)
format long
log(2.7138)
pi
format bank
pi
format rat
pi
format long
355/113

%4	Getting help
help format

%5	(Trig) functions and radians
sin(0)
sin(90)
factor(360)
sin(pi/2)
cos(0)
cos(pi/2)
help sin
sind(90)
doc sin

%6	Declaring variables 
5
5 + 5
ans + 5
ans + ans
A = 5
A
A = 7
A
B = 3
C = A + B
A = A+1
A

%7	Contrasting the assignment operator with the equality operator 
A == 8
A == 7
2 == 3
3 == (1+2)
A
B
A == B
A ~= B
A > B
A < B

%8	Discussing variable names (be careful of what you name things) and clearing them
suny = 5
numParticipants = 100
numCondExp = 7
num_cond_exp = 7
variableNamesAreYourChoice = 17
butTheyAreAlsoYourResponsibility = 19
sin = 75
sin
sin(pi/2)
clear sin
sin(pi/2)
which sin
which sine
which swine
exp7 = 10
7exp = 10
myFirstVar = 1
my First Var = 1
scalarsAreLowerCase = 39

%9 Making (vectors) linear indices 
participantsList = 1:100
evenParticipants = 0:2:100
oddParticipants = 1:2:100
evenParticipants
evenParticipants(20)
participantsList = 1:1:100
participantsList = 1:5:100
newVariable = linspace(0,1,100)

%10	Matrices: Declaration, operations, holes, square brackets
A = [1 2;3 4]
size(A)
A
A = [1, 2; 3, 4; 5, 6]
size(A)
B = A
C = A + B
D = A * B
D = A.* B
A = [1, 2;3, 4;5 ]
A = [1, 2;3, 4;5 0]
mean(A)
A
A = [1, 2;3, 4;5 nan]
nanmean(A)
A = [1, 2;3, 4;5 inf*0]
mean(A)
E = rand(2)
size(E)
A + E
E = rand(3,2)
A + E

%11	The echo operator and drawing random numbers
F = rand(1e6,1)
F = rand(1e6,1);
studentName = rand(10);
studentName

%12	Saving and loading of workspaces 
save myFirstVariables
clear all
load myFirstVariables.mat

%13 Documenting the command history
diary
help diary
diary on
diary('myFirstDiary')

%14 Accessing and changing elements of the matrix, using the colon operator
A
A(3,1)
A(3,:)
A(1:2,1)
A(3,2) = 6
mean(A,1)
mean(A,2)
A(3,:) = 5
A
Q = 5; R = 6; S = 7;
Q = 5 R = 6 S = 7

%15	The matrix transpose, operators vs. functions
A = [1 2 3; 4 5 6; 7 8 9]
B = A'
transpose(A)
C = B'
transpose(A)
2 + 3
plus(2,3)

%16 Finishing linear algebra (for now): Inner and outer product
Prices = [10 20 30 40 50]
Sales = [50; 30; 20; 10; 1]
Revenue = Prices*Sales
priceList = Sales*Prices

%17	Concatenating functions max(max(A))
A
max(A)
max(A,2)
max(A')
help max
min(A)
max(max(A))
min(max(A))

%18 Dealing with missing data and the find function
A = [1, 2;3, 4;5 inf*0]
size(A)
A(3,:) = []
size(A)
B = [1 2; 3 nan; 4 5; nan 7]
find(B==4)
[ii,jj] = find(B==4)
find(B>3)
[ii,jj] = find(B>3)
isnan(B)
find(isnan(B)==1)
[rowNumb, colNumb] = find(isnan(B)==1)
B
B(deansKillList,:) = []

%19 Linearization and reshaping of matrices
emma = pascal(6)
size(emma)
emmaFlattened = emma(:)
size(emmaFlattened)
emmaReshaped = reshape(emmaFlattened,[18 2])
size(emmaReshaped)
numel(emmaReshaped)

%20 Putting it together: Finding things in a matrix, deleting/replacing them
Nina = pascal(5)
size(Nina)
%We want to delete all rows of the Pascal's triangle that we call Nina where we have an element that is 3
find(Nina==3)
[ShannonsKillList, columnIndex] = find(Nina==3)
ShannonsKillList
[ShannonsKillList, weWillThrowThisAwayButMatlabExpectsIt] = find(Nina==3)
Nina
Nina(ShannonsKillList,:) = []
Nina

[indicesOfRowsToGetRidOf, randomTrash] = find(emma==10)
emma(indicesOfRowsToGetRidOf,:) = []
morgan = pascal(6)
find(morgan==10)
replaceThese = find(morgan==10)
morgan(replaceThese) = nan
