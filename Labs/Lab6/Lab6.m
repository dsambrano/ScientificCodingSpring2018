%% Header
% This is the lab 6 script:
    % Today's lab is very open: Student led
    % Deshawn Sambrano: DSambrano@nyu.edu
    % Version 1: 3/8/18
    % Dependencies and Assumptions: MATLAB 2015b or newer
    
%% Init
clear all
close all
clc


%% Very simple interpolation

x = [0 2];
y = x;

figure
plot(x,y)

interp1(x,y,1)


%% Adding complexity

x = [0 2];
y = [0 1];

figure
plot(x,y)

interp1(x,y,1)

%% Flipping x's and y's

x = [0 2];
y = [0 1];

figure
plot(x,y)
hold on

% plot(y,x)
% line([.5 .5], [0 1])
% line([0 .5], [1 1])

threshold = interp1(y,x,.5);
plot([threshold threshold], [0 .5], '--', 'Color', 'k')
plot([0 threshold], [.5 .5], '--', 'Color', 'k')

%% Flipping x's and y's

x = [0 2];
y = [0 1];

figure
plot(x,y, 'o-')
hold on
% plot(y,x)
% line([.5 .5], [0 1])
% line([0 .5], [1 1])

% plot([1 1], [0 .5], '--', 'Color', 'k')
% plot([0 1], [.5 .5], '--', 'Color', 'k')

interp1(y,x,.5)