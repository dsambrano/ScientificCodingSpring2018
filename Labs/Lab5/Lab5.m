%% Header
% This is the lab 5 script:
    % We will be focused on stimulus presentation and reaction times
    % Deshawn Sambrano: DSambrano@nyu.edu
    % Version 1: 3/1/18
    % Dependencies and Assumptions: MATLAB 2015b or newer
    
%% Init
clear all
close all
clc


%%

s = RandStream.create('mt19937ar', 'seed', posixtime(datetime('now', 'TimeZone', 'America/New_York')))
rng(s.Seed)
RandStream.setGlobalStream(s);