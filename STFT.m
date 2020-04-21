clc
clear
close all

%% simulate the input signal
SignalLength = 128;
t = rescale(1:SignalLength/2,0,5*pi);
x1 = sin(t);
x2 = sin(2*t);
x = [x1,x2];

%x = randn(1,128);

figure(1);
subplot(3,1,1); stem(x); title('The Signal');
xlabel('n');
ylabel('magnitude');

%% setup STFT window

w = zeros(size(x));
h = 50;

% palse window
%w(1:h) = 1;

% gaussian window
w(1:h) = gaussmf(1:h,[h/6,h/2]);


%% STFT calculation
f = rescale(1:SignalLength,-pi,pi);
mySTFT = zeros(length(w)-h, length(x));
for k = 1:length(w)-h
    w2 = circshift(w,k);
    
    F = fft(w2.*x);
    F = fftshift(F);
    M = abs(F);
    
    mySTFT(k,:) = M;

    subplot(3,1,2);
    plot(w2);
    ylim([-0.5,1.5]);
    title('STFT Window');
    xlabel('n');
    ylabel('magnitude');
    
    subplot(3,1,3);
    plot(f,M);
    title('FFT');
    xlabel('frequency');
    ylabel('magnitude');
    
    drawnow;
    
    pause(0.1);
end

figure(2);
subplot(1,2,1);
image(mySTFT*255/max(mySTFT(:)));
axis square;
title('STFT');

subplot(1,2,2);
[XX,YY] = meshgrid(f,1:length(w)-h);
mesh(XX,YY,mySTFT);
title('STFT');
xlabel('frequency');
ylabel('n');
zlabel('magnitude');
axis square;

