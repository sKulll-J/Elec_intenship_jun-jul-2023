% pkg
pkg load control
close all
clear all
%load audio and play it
[aud,Fs] = audioread("all2.wav");
display("audioread done")

player = audioplayer(aud, Fs);
%play(player);
display("Played Input")

%__display audio
figure 1
%___plot temporel
subplot(2,1,1);
N = length(aud);
t = linspace(0,N/Fs,N);
plot(t,aud);
%___plot frequency
subplot(2,1,2)
AUD = abs(fft(aud))/(N/2);
AUD=fftshift(AUD);
f = (0:N/2-1)*(Fs/N);
miAUD=AUD(N/2:end-1);
semilogx(f,abs(miAUD));
axis([100,20000])
grid on

%filter audio
R = 0.79; % Résistance en ohms
C = 10e-6; % Capacité en farads
H = tf((R*C), [R*C, 1]); % Fonction de transfert du filtre passe-bas RC

% Simulation de la réponse du filtre au signal d'entrée
y = lsim(H, aud, t); % Signal de sortie

% affichage de sortie
figure(2)
subplot(2,1,1);
N = length(y);
t = linspace(0,N/Fs,N);

plot(t,y);
%___plot frequency
subplot(2,1,2)
Y = abs(fft(y))/(N/2);
Y=fftshift(Y);
f = (0:N/2-1)*(Fs/N);
miY=Y(N/2:end-1);
semilogx(f,miY);
axis([100,20000])
grid on

%pause(0.5)

player2 = audioplayer(y, Fs);
%play(player2);

display("finish play output")

