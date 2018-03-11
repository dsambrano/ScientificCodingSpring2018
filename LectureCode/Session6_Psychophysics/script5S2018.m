%Script 5
%Psychophysics!
%Who did it? When? How to reach them? 
%Philosophy introduced today: Once you put it into a matrix, you own it. 
%You can do whatever you want with it. Show it, listen to it. 3d print it. 

%% 0 Init
clear all
close all
clc

%% 1 Understandinf how MATLAB represents images in the first place
%Idea: Every pixel on your screen contains 3 transistors
%Pixel: Picture element. Your screen has a resolution of 1440x960 or
%something like that
%You can turn the voltage of each transistor fully on, fully off or
%everything in between
%The 3 transistors correspond to 3 primary colors: Red, Green and Blue.
%Importantly, this is addition of lights, not pigments. Pigments subtract
%light. If you mix all of them, you get black. Lights add, if you add all
%of them, you get white. 
%Also, there are not an arbitrary number of voltages. There are 256 per
%"channel". Each channel is one of those transistor types. In other words,
%this is 8-bit color. 2^8 = 256, that yields a combination of about 16
%million different color. 

%Before we go there, we have to talk about how Matlab represents images to
%begin with. And for purposes of memory management, it does it somewhat
%unusually. This is also the first time we will introduce a 3D matrix. 

testDisp = uint8(zeros(7,5,3)); %This makes a 7x5 matrix that will be interpreted
%as an image by Matlab. The first 2 dimensions are a map, a bitmap. The
%last dimension represents the 3 different channels. 
%Uint8 means "unsigned integer". Unsigned means that it can only take
%positive values. That's fine for our purposes, because light can only be
%positive. At a minimum, we just turn the transistor off (0). 
%Integer: A whole number. 
%8: 8 bit, meaning that there are 256 states. From 0 to 255. Everything
%larger than that is basically infinity, which is 255 for this data type. 
%Why 8 bit? 8 bits are 1 byte. So this is the most economic way to
%represent the image, each entry in the matrix is only one byte. This
%matters. Say you make a 2 minute long movie, that would be gigantic, if
%you didn't represent it like that. 
%In other words, this is a perfect data type for images. 
image(testDisp) %Interpret the matrix as an image and show it

shg

%% Turning the center pixel on. Let's make it white
testDisp(4,3,:) = 255; 
pause
image(testDisp)
%axis equal 
shg

%The third dimension of the image matrix represents the color channel, in
%order: R, G and B. Think of this as different overlaying slides on an
%overhead projector. Adding lights, not subtracting color, think of
%kindergarten. It's bitmap

%Caroline wants to turn the upper left pixel red. Upper left: 1,1. Red is 
%the first channel. And on is 255
testDisp(1,1,1) = 255;
pause
image(testDisp)  
shg

%Mary's pixel : 
testDisp(7,5,2) = 255;
pause
image(testDisp)  
shg    

%Caroline wants to paint a whole row blue
testDisp(2,:,3) = 255;
pause
image(testDisp)  
shg    

%More advanced colors: %Bottom left yellow
testDisp(7,1,1:2) = 255;
pause
image(testDisp)  
shg    

%Fuchsia: 
testDisp(4,1,1) = 255;
testDisp(4,1,3) = 128;
pause
image(testDisp)  
shg    

%An image in MATLAB is a 3D matrix, where the first 2 dimensions represent
%the pixel coordinates and the 3rd the dimension the brightness of a given
%color intensity. In uint8. 
%Purple: 
testDisp(4,5,1) = 79;
testDisp(4,5,3) = 182;
pause
image(testDisp)  
shg

%% 2 Why uint8? Memory management
%The testdisp matrix takes up 105 bytes: 7*5*3
testDisp2 = zeros(7,5,3); %Creates a double by default
%I gave you the physical side of it. Turning voltages in a transistor on.
%This corresponds to brightness of that channel
%If we didn't do this, and made it double by default, it would take up 840
%bytes. This is an issue of efficiency. 

%% Why would anyone not represent a matrix with bytes? 
whos testDisp
whos testDisp2 %Gives you the properties of your variable
testDisp(1,1,1) = 1000; %Max value for uint8 is 255
testDisp(1,1,1) 
testDisp2(1,1,1) = 1000; %Max value for double is very large
testDisp2(1,1,1)

%% To practice this - before we move on to the dress - let's make some highly artificial stimulus
%How about a gradient? How about a 10x10 grid of pink
gradDisp = uint8(zeros(10,10,3)); %10 x 10 matrix, 3 sheets
for ii = 1:10
    for jj = 1:10
        gradDisp(ii,jj,1) = ii*10 + jj * 10; % Red
        gradDisp(ii,jj,3) = ii*10 + jj * 10; % Blue
    end
end
image(gradDisp)
shg

%% How about 10,000 shades of grey? 
gradDisp = uint8(zeros(100,100,3)); %20x20 matrix, 3 sheets
for ii = 1:100 %Going through all vertical rows
    for jj = 1:100 %Going through all horizontal columns
        gradDisp(ii,jj,:) = ii + jj; 
    end
end
image(gradDisp)
shg

%% 4 Let's talk about handling images - we start with #thedress
%The "dress code"
%) Loading the dress into Matlab
%Download the dress file
dress = imread('thedress.jpg'); %Put the image file into matrix format
D = whos('dress')
figure
image(dress)
%The dress has been stretched. So let's fix that
axis equal

%Now that we have the dress in a matrix, we can do whatever we want with
%it.
%For instance, look at one color channel at a time
%Very Warhol
figure
subplot(2,2,1)
image(dress) %Full dress
subplot(2,2,2)
redChannel = dress; %Make a copy of the dress
redChannel(:,:,2:3) = 0; %Turn all other channels off
image(redChannel)
subplot(2,2,3)
greenChannel = dress;
greenChannel(:,:,[1 3]) = 0; %Turn red and blue off
image(greenChannel)

subplot(2,2,4)
blueChannel = dress;
blueChannel(:,:,1:2) = 0; %Turn red and green off
image(blueChannel)

%To prove this point, let's add the channels back together
figure
provePoint = redChannel + greenChannel + blueChannel; 
image(provePoint)
shg

%% Before we do image manipulations, let's listen to the dress
flatDress = dress(:); %One vector
fs = 8000;
soundsc(real(double(flatDress)),fs)
plot(flatDress)

%% Let's do same basic image analysis of the dress
figure
image(dress)
shg
pause
image(flipud(dress)) %Flip matrix upside down
shg
pause
image(fliplr(dress)) %Flip matrix left and right

%% For instance, we can make the entire dress brighter. Early on, someone proposed that this is just
%a function of screen brightness (Steve Macknick for Scientific American) 
figure
dress2 = dress; %Make a copy of the dress
for ii = 1:100 %Turning it brighter gradually
    dress2 = dress2 + 1;
    image(dress2)
    pause(0.1)
        shg

end

%% How about making it blue-er?


figure
dress2 = dress; %Make a copy of the dress
for ii = 1:100 %Turning it bluer gradually
    dress2(:,:,3) = dress2 (:,:,3) + 1;
    image(dress2)
        pause(0.1)
    shg

end

%% Deans concern: Instead of turning the whole image blue, let's just amplify pixels that are already blue
%Which is fair
listOfBluePixels = find(dress(:,:,3)>100); %Find any pixels that have a hint of blue
contrastMatrix = double(dress(:,:,3))-double(dress(:,:,1))-double(dress(:,:,2)); 
dressCopy = repmat(contrastMatrix,[1,1,3]);
listOfBluePixels = find(dress(:,:,3)>-30); %Find any pixels that have a hint of blue

figure
dress3 = dress;

for ii = 1:100 %Turning it bluer gradually
    dress3(listOfBluePixels) = dress3(listOfBluePixels) + 1;
    image(dress3)
        pause(0.1)
    shg

end

%% Inverting the colors. If you had done this in March 2015, you would have gotten a Current
%Biology paper out of it. Because they showed that only the original image
%is ambiguous, not the inverted one
dressInverted = 255 - dress; %Literally it
figure
image(dressInverted)

%% How about making only a part of the image darker, say the top half
figure
dress4 = dress; 
for ii = 1:100
    dress4(1:375,:,:) = dress4(1:375,:,:) -1; 
image(dress4)
shg
pause(0.1)
end

%% Let's pick out individual channels and represent them in 3D
%This is actually our first 3d plot
figure
h = surf(double(dress(:,:,3))); %Only looking at the blue channel in 3d
%Interpret the matrix as a surface. 
set(h,'linestyle','none') %Take the grid off
colorbar
colormap('jet') %This used to be the default until 2014b

%% In the interest of time, we'll talk about how to understand convolution next time
%But we can still use it today to blur the image
%For instance, one could easy say that people see it black and blue vs.
%white and gold because the critical information is in different spatial
%frequency channels
figure
image(dress) %Unfiltered image
pause
amountOfBlur = 20;
kernel = ones(amountOfBlur); %To convolve, one needs a kernel. Basically, how many pixels to smear together
lpDress = convn(dress,kernel,'same'); %Same size
lpDress = lpDress./sum(sum(kernel)); %If we don't divide by the kernel sum, we go out of range (of 255)
image(uint8(round(lpDress))); %Back to integers
shg

%% Edge detection
hpDress = dress-uint8(lpDress); %Edge detection - subtracting the blurry version from the original
temp = find(hpDress > 50); %some kind of threshold
hpDress(temp) = 255; %Full on
image(uint8(hpDress))
shg

%% Alternative way: Don't compute the low pass first, simply detect the differential and amplify it
overallGradient = dress(:,:,1)+dress(:,:,2)+dress(:,:,3);
diffIm = diff(overallGradient);
threshold = 0;
diffIm(find(diffIm>threshold)) = 255;
imagesc(diffIm); %Scales the image from 0 to 255
colormap('bone') %Make it greyscale

%Let's talk about colormaps. A colormap is any mapping of values
%to colors. There are many pre-defined ones. But I don't like any of them
%I make my own. You can have an arbitary number of shades
%BUT it has to be ",3" martix. Because the values are interpreted
%in order - R, G, B.
france = [0 0 1; 1 1 1; 1 0 0]; %Blue, white, red
colormap(france)
franceEnhanced = [0 0 1; 0 0 0.5; 1 1 1; 0.5 0 0; 1 0 0];
colormap(franceEnhanced)

%This colormap emphasizes extreme values but doesn't differentiate much
%Can we make one that goes from red to blue through white?
A = (1:-0.01:0)'; %From 1 to 0
B = flipud(A); 
C1 = (0:0.01:0.5)'; 
C2 = flipud(C1);
C2(1,:) = []; %Eliminate double entry
C = [C1;C2]
gradualFrance = [B C A]; 
colormap(gradualFrance)
shg

%% Making 2d exponentials, sine waves and gabors
%1 The gaussian
%For all of these - in 2d, you need a scaffolding
%We use gradients in x and y, they are created by meshgrid
n = 101; %101 points in the grid
[X,Y] = meshgrid(linspace(-2,2,n)); %meshgrid just creates gradients
figure
subplot(1,2,1)
imagesc(X)
colorbar
subplot(1,2,2)
imagesc(Y)
colorbar

gaussian = exp(-X.^2-Y.^2); %For instance
figure
image((255*gaussian) + 1)
colormap(gray(256))
axis off
axis equal
shg

%% Sine wave
numCycles = 9;
[X,Y] = meshgrid(linspace(-pi,pi,n)); %meshgrid just creates gradients
sineWave2D = sin(numCycles *X) ; %The number is the spatial frequency
figure
imagesc(sineWave2D)
colormap(gray(256))
axis off
axis equal
shg

%% Gabor
Gabor = gaussian .* sineWave2D;
figure
imagesc(Gabor)
axis off
axis equal
colormap(gray(256))
shg

%% How would you create 2 Gabors next to each other?
%Most psychophysics experiments have you judge 2 stimuli
%relative to each other, not absolutely. 
Gabor2 = cat(2, Gabor, Gabor); %2D concatenation. There is a matrix underlying all of this
figure
imagesc(Gabor2)
axis off
axis equal
colormap(gray(256))
shg

%% There are many ways to create rotated gabors. One would be 
%to use a rotation matrix. But that gets us too deep
%into linear algebra. I'll explain that in Math Tools.
%For now, let's just use trig. 
figure
for ii = 0:359
angle = ii; %Rotation angle
sf = 5; %Number of cycles
ramp = cos(angle*pi/180)*X - sin(angle*pi/180) * Y; %In radians
%imagesc(ramp)
%axis off
%axis equal
%colormap(gray(256))
%shg
%pause
orientedGrating = sin(sf * ramp);
orientedWindowedGrating = orientedGrating .* gaussian;
jointGratings = cat(2,orientedGrating,orientedWindowedGrating);
imagesc(jointGratings)
axis off
axis equal
colormap(gray(256))
shg
pause(0.1)
%Logic: Create an oriented ramp or gradient.
%Then take the sine of that. 
end