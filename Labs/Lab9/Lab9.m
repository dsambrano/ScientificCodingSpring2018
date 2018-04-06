%% Lab Intro to Fourier transform
    % Date: 4/5/18
    % TA: Deshawn Sambrano
    % DSambrano@nyu.edu
    % Version 1

%% init
close all
clear all
clc


%% 1. 

fs = 1000;
dur = 5;
t = 0:1/fs:dur;
sigFreq1 = 3;
Signal1 = sin(2*pi*sigFreq1*t);
sigFreq2 = 2;
Signal2 = sin(2*pi*sigFreq2*t);
jointSignal = Signal1 + Signal2;


figure
subplot(3,1,1)
plot(t,Signal1)
subplot(3,1,2)
plot(t,Signal2)
subplot(3,1,3)
plot(t,jointSignal)

%% Using the Fourier transform

n = length(t);
noise = randn(1,n);
signalAndNoise = jointSignal + noise;


figure
subplot(3,1,1)
plot(t,jointSignal)
subplot(3,1,2)
plot(t,signalAndNoise)
subplot(3,1,3)

nyquist = fs/2; % Half the smapling frequency
fSpaceSignal = fft(signalAndNoise) ./ sqrt(n);
fBase = linspace(0,nyquist,floor(length(signalAndNoise)/2+1));
halfSignal = fSpaceSignal(1:length(fBase));

complexConjugate = conj(halfSignal);
power = halfSignal .* complexConjugate;
stem(fBase(1:50),power(1:50))
xlabel('Frequency')
ylabel('Power')


%% Comets
dur = 1;
t = 0:1/fs:dur;

figure
trace = exp(i*pi*5*t);
comet3(t,real(trace),imag(trace))
xlabel('t')
ylabel('real')
zlabel('imaginary')
axis equal
axis square

pause;
set(gca,'view',[0,0])
pause;
set(gca,'view',[90,0])

%% Phase shift

figure

for theta = -2*pi:.05:2*pi
    dur = 1;
    freq = 20;
    t = 0:1/fs:dur;
    signal = sin(2*pi*freq*t+theta);
    fftsig = fft(signal);
    nyquist = length(fftsig)/2;
    fBase = linspace(0,nyquist,floor(length(fftsig)/2+1));        
    subplot(3,1,1)
    plot(t,signal)
    title('Signal in Time Domain')
    xlabel('time in seconds')
    ylabel('Amplitude')
    subplot(3,1,2)
    power = fftsig(1:length(fBase)) .* conj(fftsig(1:length(fBase)));
    stem(fBase,power)
    xlim([0 50])
    title('Signal power in Freq domain')
    xlabel('Frequency')
    ylabel('Power')
    subplot(3,1,3)
    
    [val, ind] = max(power);
    phaseAngle = angle(fftsig(ind));
    plot(phaseAngle, 1, 'o', 'markerfacecolor', 'k')
    xlim([-pi, pi])
    ylim([0,1.1])
    ylabel('Shift (y or n)')
    xlabel('Phase Shift in pi')
    title(['Phase angle of the signal where power is maximal: ', num2str(phaseAngle,'%1.2f')])
    shg
    pause(.01)
    
end




