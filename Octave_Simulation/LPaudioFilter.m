% pkg
pkg load control
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
mN = round(N/2);
t = linspace(0,N/Fs,N);
plot(t,aud);
%___plot frequency
subplot(2,1,2)
AUD = abs(fft(aud))/double(mN);
AUD=fftshift(AUD);
f = (1:mN)*(Fs/N);
miAUD=AUD(mN:length(AUD));
semilogx(f,abs(miAUD));
axis([100,20000])
grid on

%filter audio
R = 1000; % Résistance en ohms
C = 2.5e-6; % Capacité en farads
H = tf(1, [R*C, 1]); % Fonction de transfert du filtre passe-bas RC

% Simulation de la réponse du filtre au signal d'entrée
y = lsim(H, aud, t); % Signal de sortie

% affichage de sortie
figure(2)
subplot(2,1,1);
N = length(y);
mN = round(N/2);
t = linspace(0,N/Fs,N);

gain = 5

y=gain*y;

plot(t,y);
%___plot frequency
subplot(2,1,2)
Y = abs(fft(y))/double(mN);
Y=fftshift(Y);
f = (1:mN)*(Fs/N);
miY=Y(mN:length(AUD));
semilogx(f,abs(miY));
axis([100,20000])
grid on

%pause(0.5)

%amplification
figure(3)
Cvar=linspace(2.5e-6,50e-8,100)';
f=f(1:round(length(f)/100):end-1);
H=1./sqrt(1+(R*2*pi.*Cvar.*f).^2);
semilogx(f,Cvar, H);
grid on
axis([200,20000])

player2 = audioplayer(y, Fs);
%play(player2);

display("finish play output")

