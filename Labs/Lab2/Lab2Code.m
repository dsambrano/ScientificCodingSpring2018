%%

%% 0 Init
clear all
close all
clc

% This code will change you working directory to the location of the current
% file. Be sure to save the MATLAB file before hand.
olddir = pwd;
tmp = matlab.desktop.editor.getActive; 
newdir = fileparts(tmp.Filename)
cd(newdir);

load('Assignment1_data.mat')
%% Problem 1
load('Assignment1_data.mat')




%% Problem 2



%%
x = 1:10
y = [sin(x) 0]
figure
plot(x,y)
size(x)
size(y)


y = sin(x)
figure
plot(x,y)