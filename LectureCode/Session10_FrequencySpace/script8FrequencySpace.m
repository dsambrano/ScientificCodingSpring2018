%In this script, we will explore frequency space
%Who did this?
%When

%% 0 Init
clear all
close all
clc
fs = 1000; %Sampling rate. How often do we take samples from a - theoretically - continuous signal
t = 0:1/fs:1; %Define a timebase as the number of steps in terms of sampling rate
freq = 30; %Some signal frequency. In Hz. The signal repeats 30 times a second
signal1 = sin(2*pi*freq.*t); %The general equation of a sine wave

%% 1 Illustrate the need for spectrograms
figure
subplot(2,2,1)
plot(t,signal1) %Pure sine wave as a signal, over time. 
title('1 sine wave, 30 Hz')
shg
%If we have a pure sine wave as a signal, we can simply count the number of
%cycles to ascertain the frequency. We do not need a FFT. 
signal2 = signal1 + randn(1,length(signal1)); %First signal plus a smidgen of noise
%By the way: This is the best possible situation. The noise is not biasing
%you. But even this mild noise will mess you up visually. 
subplot(2,2,2)
plot(t,signal2) %Even if you add just the best possible way of noise 
%Which is inevitable, due to measurement errors (you will always have
%random noise). In addition to death and taxes.
title('1 sine wave, 30 Hz plus noise from a random normal distribution')
shg
freq2 = 60; %New signal at twice the frequency
signal3 = signal1 + sin(2.*pi.*freq2.*t); %Adding 2 pure sine waves
subplot(2,2,3)
plot(t,signal3)
title('2 sine waves, 30 and 60 Hz')
%This is an inverse problem (that your brain solves routinely, using FT,
%actually. It is pretty much impossible to decompose the output into the 
%component input frequencies. This would make a nice little game.
signal4 = signal3 + randn(1,length(signal3)); %Noise is inevitable
subplot(2,2,4)
plot(t,signal4),
title('2 sine waves, 30 and 60 Hz, plus noise')
shg

%Hopefully, it should now be obvious - just by visual inspection - why we
%NEED TO look into frequency space. We have to. If we want to know what the
%inputs/components are. There are lots of reasons why we want to know. 
%We will now look at *the same data* but not from the perspective of the 
%time domain. We will look in frequency space, which is the natural habitat
%of sine waves and Larry Maloney.
%This perspective emphasizes how often something happens over WHEN it
%happened. Different perspectives have different advantages and
%disadvantages. That is why we celebrate diversity.
%If you integrate over time, you lose timing information. 

%% 2 The actual spectrogram
%Before we make the spectrogram, let's look at the actual windows we could
%use
wind = hamming(64); %This creates a 64 point (or 64 samples) hamming window
%We can look at this window with the wvtool (window visualization tool)
wvtool(wind)
%To understand where the ripples come from, you have to understand that any
%sharp edge in the time domain will correspond to a sinc function in the
%frequency domain
%The FT of a sharp edge is a sinc function. It looks like the trace of a
%tennis ball once you drop it. 
figure
t = linspace(0,5);
    y = sinc(t);
    plot(t,y);
    xlabel('Time (sec)');ylabel('Amplitude'); title('Sinc Function')
    shg
    
    %In other words, things look like they ripple because the FT of a sharp edge is
    %a sinc function, which ripples.
    %Why ripples are inevitable is obvious if you look at a narrow window
    %with like 8 samples.
    %But even a high resolution (or broad) window will ripple because it is
    %ultimately discrete - individual points are connected by lines.
    %The smoother it is, the more subdued the ripples will be. But they
    %will always be there.
    
    %The hamming window actually doesn't go from 0 to 1, which causes all
    %kinds of problems. Let's find a window that does.
%%
    wind = hanning(64);
    wvtool(wind)
    wind2 = hamming(64);
wvtool(wind2)
wind3 = kaiser(64);
wvtool(wind3)
wind4 = bartlett(64);
wvtool(wind4)
    
%After picking a window shape, we get to pick the shift. And in reality, we
%get to pick the inverse of the shift, namely the overlap. 
overl = length(wind)-1; %This is the minimal possible shift, maximal overlap
overl2 = 0; %The maximal shift (minimal overlap). This will be much, much faster. The bigger the window, the more of a difference this makes
%These are extremes, you can pick anything in between. And in 2018, all
%alarm bells should be ringing because you have tremendous researcher
%degrees of freedom. 
ySubDivisions = [0:5:100]; %These are frequency bands we care about. 
%The broader we make them, the more information we have to estimate what is
%in them, but it will be coarse. The finer we make them, the better the
%resolution, but it will be noisier. 
figure
subplot(2,2,1)
spectrogram(signal1,wind,overl,ySubDivisions,fs,'yaxis') %'yaxis' flips the x and y axis
%The spectrogram function does tons of FTs, and stacks the results over
%time. That's it. You are looking at the results of doing lots of fourier
%transforms. Windowed and shifted Fourier transforms
shg

%Basically, it worked. We expected maximal power at 30 Hz, because we know
%"ground truth". But that is not what we get. The spectrogram is messing
%with us. Because we know ground truth, we know it is. 
%There is considerable reported power in the off-peak regions (outside of
%30 Hz) and there is rippling noise all over the place. 
%All of that stems from windowing. The FFT is done only over 64 sample
%snippets. So artifacts are inevitable. Due to uncertainty. 
%The technical term for this is: "Leaking out" or "Smearing" of power. 
%Solution: More data to do the FT on, which means: We need a bigger boat
%Window.
%%
wind = hamming(256);
overl = length(wind)-1;
spectrogram(signal1,wind,overl,ySubDivisions,fs,'yaxis')
%Prediction: We now use 4 times as much information in our window as
%before. This should tighten our estimate of the frequency content in the
%y-axis. 
shg
%And it did. However, it did not get rid of the weird rippling in the
%background. Making the window longer/broader got rid of the power leakage.
%What are we going to do about the ripples?
%The only way to deal with the ripples is to change the shape of the window
subplot(2,2,2)
wind2 = chebwin(256);
spectrogram(signal1,wind2,overl,ySubDivisions,fs,'yaxis')
%General tradeoff: Window shape trades off the precision of the estimation of power in the
%signal frequency vs. the rippling in the noise. 
%This seems dumb in this case, but that's because it is a very
%nonrepresentative case. There is no noise (!), the signal is stationary
%(does not vary over time) and there is only one signal frequency. In
%reality, all 3 of these things are different, so the right tradeoff is far
%from obvious. 
shg

%But let's go back to the initial problem: We could not tell the component
%frequencies of a relatively simple (2 sources, some noise) signal
%visually. Can a spectrogram do better?
%%
figure
wind = hamming(512);
overl = length(wind)-1;

spectrogram(signal4,wind,overl,ySubDivisions,fs,'yaxis')

%As you can see, spectrogram are all about tradeoffs. 
%Mostly about signal frequency power vs. noise power.
%But also when vs. what. Our signal hasn't varied yet, so we don't know
%this yet.
%This does not change the fact that doing a spectrogram (which is just
%doing a lot of DFTs over time allows you to do things that you cannot do
%in any other way).
%Does something have to be perfect in order to be good? No.

%% 3 Let's move on to the meat of the matter: Why are we are doing spectrograms in the 
%first place. Why not just do FTs. 
%Time varying signals. If the signal is not varying in time, you are best
%advised to do a single FT that uses the entire signal. Don't window.
%That uses all the data and there are no windowing artifacts. 
%The spectrogram is an attempt to have your cake and eat it too.
%Let's create a time-varying signal with a function.
%The simplest I can think of in Matlab is a chirp. 
%It actual has recently gained scientific prominence too, because that is
%the sound that 2 colliding black holes make. Google it.
figure
wind = chebwin(256);
overl = length(wind)-1;
fPoints = 0:10:500; %Number of frequency points on y axis
t = 0:1/fs:2; %2 second signal
yChrp = chirp(t,100,1,200,'quadratic'); %Time base, starting frequency, time to reach target, target, shape
sound(yChrp,fs)
subplot(2,1,1)
plot(t,yChrp) 
shg %Looking at this in the time domain will be hopeless. Unless you are a savant.
subplot(2,1,2)
spectrogram(yChrp,wind,overl,fPoints,fs,'yaxis')
%With a time-varying signal, a larger window is all of a sudden no longer
%such an obvious choice because we average over a lot of stuff that happens
%in the window. The longer, the worse this is.

%Frequently (and easily) made mistake: xlim =  (!)
%Overwrites it, and makes it a variable


%% 4 Filtering
%Very important topic for signal processing. Any real physiological signal
%will be noisy. You kind of have to filter out the noise to be able to see
%what you want to see. 

%In principle, there are 4 kinds of filters. You can build all others from
%these 4 basic kinds:
%1) High pass filter: *Passes* high frequencies, attenuates low frequencies
%2) Low pass filter: *Passes* low frequencies, attenuates high frequencies
%3) Band pass filter: Passes everything inside a range, attenuates outside
%4) Notch filter: Attenuates everything in a given range, passes everything
%outside of it. In the US, you kind of have to put a notch filter at 60 Hz,
%in Europe at 50 Hz, otherwise the power from the AC will dominate
%everything else. 

%There are many filters. There is no way to cover more than 2 here. But
%these are the 2 that are by far the most commonly used. 
%1) Is the Butterworth filter. Just like the FT, *all* filtering distorts
%the signal. In a certain way. Your choice: HOW it distorts it. The
%butterworth filter is a maximally smooth filter in terms of the frequency
%content of the pass band. Like butter. This comes at a price: There are -
%sometimes serious - distortions in the attenuation band. 

%In Matlab, the shape of the filter is defined by 2 coefficients. You can
%ask the "order" of the filter. This is implemented with polynomials. In
%practice, in hardware filters this more or less corresponds to the number
%of transistors in the filter. 

order = 5; 
[B,A] = butter(order,0.6,'low') %1st argument: order, 2nd: Cutoff frequency in terms of Nyquist (!), 3rd: Type
[B2,A2] = butter(order,0.4,'high') %The complementary high pass filter. 
[B3, A3] = cheby1(order,5,0.6,'low') %The analogous Chebyshev filter

%Before we do anything else with the filters, I want to show you how to
%look at the filters themselves
fvtool(B,A) %This is the filter visualization tool 
fvtool(B3,A3) %Looking at the chebichev filter

%% 5 Let's actually use the filter to filter the chirp
yLow = filtfilt(B,A,yChrp) %Low pass filtering. Filtfilt: First forward, then again backward --> No phase shift
yHigh = filtfilt(B2,A2,yChrp) %High pass filtering. Filtfilt: First forward, then again backward --> No phase shift
yBand = filtfilt(B,A,yHigh) %Filtering the high pass filter signal again low-passed --> Bandpass

wind = hanning(256)
overl= 255;

figure
subplot(4,1,1)
spectrogram(yChrp,wind,overl,fPoints,fs,'yaxis')
subplot(4,1,2)
spectrogram(yLow,wind,overl,fPoints,fs,'yaxis')
subplot(4,1,3)
spectrogram(yHigh,wind,overl,fPoints,fs,'yaxis')
subplot(4,1,4)
spectrogram(yBand,wind,overl,fPoints,fs,'yaxis')
shg

sound(yChrp,fs)
pause
sound(yLow,fs)
pause
sound(yHigh,fs)
pause
sound(yBand,fs)
pause





