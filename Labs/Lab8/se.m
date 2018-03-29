function [ sem ] = se( x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    % Most people want 2 * standard error of the mean.

    sem = std(x)./sqrt(length(x))
end

