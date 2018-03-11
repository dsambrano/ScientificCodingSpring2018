function [ SUM, vector ] = myFirstFunction( I, N )
% myFirstFunction will sum a list of number
%   SUM = myFirstFunction(N) will sum the values from 1 to N and return the
%   summed value
%
%   SUM = myFirstFunction(I, N) will sum the values from I to N and return
%   the summed value



% In order to make a function, you will need to make the function name
% match the file name. And for now, we need to make sure that the function
% file is in our current working directory. To adress Dan's concern, we
% will change that at the end. 


% We should also ensure that our output (in this case SUM see what is
% before the '=' sign above) is define somewhere inside the function.

% Specify input arguments above inside the parantheses and they will be
% able to be used anywhere in the function. 

% Functions will not interefere with your workspace AT ALL. This a good
% thing!!!! But if we want to have access to multiple things created inside
% the function, we have to do a few things. First, we need to add it to the
% output section of the fuction, e.g., in the brackets before the = sign at
% the top. Then, to get both variables, we need to call the function with
% multiple outputs like so: [SUM, vector] = myFirstFunction(5)
% Note, we could have named the output anything just like normal but for
% this case we made it simple. 



    if nargin == 1
        N = I;
        I = 1;
    end
            



    vector = I:N;
    SUM = sum(vector);
    
    
end

