%% Header
% This is the lab 4 script:
    % We will be focused on stimulus presentation and reaction times
    % Deshawn Sambrano: DSambrano@nyu.edu
    % Version 1: 2/22/18
    % Dependencies and Assumptions: MATLAB 2015b or newer
    
%% Init
clear all
close all
clc

% Constant


%% Why use NaNs

x = 1:10;
mean(x)

zVector = zeros(1,100);
nVector = nan(1,100);

for i = x
    zVector(i) = i;
    nVector(i) = i;
end
mean(zVector)
mean(nVector)
    

%% Creating a single trial
stimulusVector = [4, 8, 12, 16]


figure


for j = 1:10
    
    if j == 1
        welcomeText = text(.5,.5,'Welcome!')
        axis off
        set(gcf,'color','k') % Set background color to black
        set(welcomeText,'color','w') % Maybe make it bold
        set(welcomeText,'Fontsize',40)
        shg
        pause
        delete(welcomeText)
    end

        
    % Stimuli Number
    numStim = stimulusVector(randi(4));


    targetPresent = randi(2)-1
    distTemp = randi(2,1,numStim-targetPresent)
    distractorVector = cell(1,length(distTemp))
    for i = 1:length(distTemp)
        if distTemp(i) == 1
            distractorVector{i} = 'o'
        else 
            distractorVector{i} = 'x'
        end
    end


    distractorPositions = rand(numStim-targetPresent,2); % Each row represents the X,Y coord for each distractor

    distractorsOutput = text(distractorPositions(:,1), distractorPositions(:,2), distractorVector)



    set(distractorsOutput,'Fontsize',20)
    set(distractorsOutput,'color','g') % Maybe make it bold



    targetPosition = rand(targetPresent,2); % Each row represents the X,Y coord for each target

    targetOutput = text(targetPosition(:,1), targetPosition(:,2), 'x')

    set(targetOutput,'Fontsize',20)
    set(targetOutput,'color','r') % Maybe make it bold
    

    shg
    pause
    delete(targetOutput)
    delete(distractorsOutput)

end



%% Lab 2

%% Creating a single trial
stimulusVector = [4, 8, 12, 16];


hFigure = figure
set(hFigure, 'MenuBar', 'none');
set(hFigure, 'ToolBar', 'none');

for j = 1:6
    
    if j == 1
        welcomeText = text(.5,.5,'Welcome!')
        axis off
        set(gcf,'color','k') % Set background color to black
        set(welcomeText,'color','w') % Maybe make it bold
        set(welcomeText,'Fontsize',40)
        shg
        pause
        delete(welcomeText)
    end

        
    % Stimuli Number
    numStim = stimulusVector(randi(4));


    targetPresent = randi(2)-1;
    distTemp = randi(2,1,numStim-targetPresent)
    distractorVector = cell(1,length(distTemp))
    for i = 1:length(distTemp)
        if distTemp(i) == 1
            distractorVector{i} = 'o'
        else 
            distractorVector{i} = 'x'
        end
    end


    distractorPositions = rand(numStim-targetPresent,2); % Each row represents the X,Y coord for each distractor

    distractorsOutput = text(distractorPositions(:,1), distractorPositions(:,2), distractorVector)



    set(distractorsOutput,'Fontsize',20)
    set(distractorsOutput,'color','g') % Maybe make it bold
    



    targetPosition = rand(targetPresent,2); % Each row represents the X,Y coord for each target

    targetOutput = text(targetPosition(:,1), targetPosition(:,2), 'x')

    set(targetOutput,'Fontsize',20)
    set(targetOutput,'color','r') % Maybe make it bold

    shg
    tic
    pause
    userInput = get(hFigure, 'CurrentCharacter')
    if strcmp(userInput, 'p')
        rt = toc
    end
    delete(targetOutput)
    delete(distractorsOutput)
    
end



