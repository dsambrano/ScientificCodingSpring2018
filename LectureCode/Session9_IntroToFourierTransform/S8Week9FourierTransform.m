%In this script, we will build up an understanding of the Fourier Transform
%Next week, we'll apply this knowledge. 
%In other words, today, we'll try to get to Frequency space.
%Next week, we'll explore what there is to do, once we get there.
%Shenanigans. What we actually did was explore sounds. 
%04/03/2018

%% 1 Creating simple periodic signals
%Defining the parameters to make the actual signal
fs = 1000; %Sampling frequency. The rate at which we measure ("sample") the data, in time. 
%How many times per second. (Frequency has the unit of times per second)
dur = 1; %How long is the stimulus/signal, in time (unit is second)
t = 0:1/fs:dur; %Create a time base (which we will use as an x-axis), going from 0 to the full duration
%Stepsize: We want to see each sample. So the signal has fs values.
sigFreq = 5; %This is the signal frequency. How often the signal repeats per second (Hz)
amplitude = 7; %How big our signal is. "Tall"

%Now we have all the parts. What is the equation of a sine wave in the time domain?
sinW = amplitude.*sin(2*pi*sigFreq*t); 
cosW = amplitude.*cos(2*pi*sigFreq*t); 
%Note: We haven't messed with phase yet. In the interest of completelyness,
%you would add that as a plus. It just shifts the signal back and forth.
%Actually, the cos *is* the sin, 90 degrees shifted. But if you want to
%know more about that, take Math Tools. We actually won't mess with phase
%here. 

%Plotting it
figure
subplot(2,1,1)
plot(t,sinW,'color','b','linewidth',4)
subplot(2,1,2)
plot(t,cosW,'color','r','linewidth',4)
shg

%% 2 There is another way to write sine waves, without explicitly invoking
%trig functions. Sine waves are complex exponentials. Because that's how
%Fourier uses them, it is worth pausing and showing that. So that's what we
%do now. Goal: Write a sine wave without using sin and cos.

figure
trace = exp(2*pi*i*sigFreq*t)
comet3(t,real(trace),imag(trace))
pause
figure
h = plot3(t,real(trace),imag(trace));
xlabel('time')
ylabel('real part')
zlabel('imaginary part')
set(h,'color','k')
pause
set(gca,'View',[0 90]) %This sets the perspective of the camera, real part of the slinky over time
pause
set(gca,'View',[90 0]) %This sets the perspective of the camera, imaginary part of the slinky as a function of the real part
axis square

%% 3 Why should you care? Because many signals are periodic. Notably all sounds.
%So we briefly illustrate the utility of defining signals that way.
%THEN we'll do fourier transform to manipulate them
%Of course, sounds are complex periodic signals (which we'll deal with next
%time), for now, we will deal with pure tones (single sine waves)
fs = 44100; %Twice the upper range of hearing of a young child, CD quality
freq1 = 220; %Low A
freq2 = 440; %Higher A
freq3 = 880; %Even an octave higher than that

%The reason we need to redefine the time base is because we changed the
%sampling frequency. This is not excel
t = 0:1/fs:dur; 
y1 = sin(2.*pi*freq1*t); %Low A
y2 = sin(2.*pi*freq2*t); %Moderate A
y3 = sin(2.*pi*freq3*t); %Moderate A

sound(y1,fs)
pause(1)
sound(y2,fs)
pause(1)
sound(y3,fs)

%Sound physics: Every sound is generated by pushing a column of air (or
%water). In most cases that will be by a membrane (like a speaker). What
%"sound" does is to interpret the values in a data matrix (usually from -1
%to 1) as the relative positions of that membrane over time. 1 number per
%unit time. If you have stereo (two speakers), it is two numbers per time. 
%This movement of air molecules is interpreted by your brain as sound. 

%% 4 White noise
sound(rand(40000,1),fs); %White noise

%% 5 Chords: More than one major note at a time
y = (y1+y2+y3)./3; %Divide by 3 to avoid clipping
sound(y,fs) 

%Compare and contrast to what happens if you don't divide - it will clip.
%You could - in principle - design your own ringtones and sell them.
%If you don't want to divide, use soundsc - that scales the matrix to go
%from -1 to 1. No clipping

%Suggestion for final project: Create your own musical instrument in
%MATLAB. Transcending the limitations of physical instruments. The problem
%is that instrument makers have been limited by the physical properties of
%what they can get to resonate. Consequently, most of the possible
%frequency space has been unexplored / unused in music. 
%% 6 Audio player

figure
data = audioread('034_BritneySpears_BabyOneMoreTime.mp3_15.mp4');
plot(data(:,1))
xlim([0 length(data)])
shg
sound(data(:,1),fs)
%pause
%clear sound %Kills sound (mute)
h = line([0 0],ylim,'color','r') %Define a line
  
for ii = 0:0.1:15
set(h,'XData',[ii*fs ii*fs]); %New position of the line      
pause(0.09755) %Wait for 100 ms


end

%% 7 Audio recorder
%Let's build a recording studio, right here in MATLAB
recObj = audiorecorder(44100, 24, 1); %Create a recording object, good quality
pause(0.5)
disp('Talk')
recordblocking(recObj,3) %This records the microphone input for 3 seconds
disp('Done')
ySpeech = getaudiodata(recObj); %Getting the audio data out of the object
fs2 = recObj.SampleRate; %Get the sampling rate out
figure
plot(ySpeech)
%Playback 
sound(ySpeech,fs2) %Default is phone quality. Hence us specifying better quality

%% 8 Writing audio data to the drive
audiowrite('mySpeech.mp4',ySpeech,44100);



