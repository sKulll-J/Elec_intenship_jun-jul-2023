pkg load control
close all
clear all
% Génération d'un signal sinusoïdal
Fs = 9999; % Fréquence d'échantillonnage
t = 0:1/Fs:1; % Vecteur temps
s1 = sin(2*pi*1*t);
s2=sin(2*pi*5*t);
s3=sin(2*pi*50*t);
x = s1 + s2+s3; % Signal sinusoïdal

% Conception d'un filtre passe-bas RC
R = 10000; % Résistance en ohms
C = 1e-5; % Capacité en farads
H = tf(1, [R*C, 1]); % Fonction de transfert du filtre passe-bas RC

% Simulation de la réponse du filtre au signal d'entrée
y = lsim(H, x, t); % Signal de sortie

% Tracé des signaux d'entrée et de sortie
subplot(2,1,1)
plot(t, s1, 'b',t, s2, 'g',t, s3, 'c', t, y, 'r')
legend('Signal dentrée 1','Signal dentrée 2', 'Signal de sortie')
xlabel('Temps (s)')
ylabel('Amplitude')

subplot(2,1,2)
X = fft(x);
X= fftshift(X);
Y = fft(y);
Y=fftshift(Y);
hold on

N=length(X);
fmin = Fs/N; % Fréquence minimale
fmax = Fs/2; % Fréquence maximale
%f = logspace(log10(fmin), log10(fmax), N);
f = logspace(log10(fmin),log10(fmax),length(Y));
length(abs(X)(N/2:end))
semilogx(f(1:N/2),abs(X)(N/2:end-1),'b')

semilogx(f(1:N/2),abs(Y)(N/2:end-1),'r')
%axis([1 10])
grid on
hold off
