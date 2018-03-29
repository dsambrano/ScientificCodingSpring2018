function [ normalizedVariable ] = normalizer(someVariable)
%This function z-scores ("normalizes") an input
%Output: The normalized input, in units of SD
%Pascal Wallisch
%03/27/2018

normalizedVariable = (someVariable-mean(someVariable))./std(someVariable);


end

