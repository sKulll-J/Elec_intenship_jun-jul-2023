%code simple
pkg load control
clear all
clear figure
close all

Fs = 1005; % Fréquence d'échantillonnage
t = 0:1/Fs:1; % Vecteur temps
N= length(t);

in1 = 1.5*sin(2*pi*t); % Signal sinusoïdal
in2 = sin(2*pi*40*t);
in=in2;

figure 1
plot(t, in)

figure 2
Y = fft(in,N)/length(in); % Transformée de Fourier discrète du signal

stem(abs(Y))

%f = (-N/2:N/2-1)*(Fs);
%midY = abs(Y);
%stem(f,midY)
