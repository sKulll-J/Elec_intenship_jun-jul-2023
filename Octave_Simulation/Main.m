pkg load control
clear all
clear figure
close all

pkg load control
%load audio and play it
[aud,Fs] = audioread("all3.wav");
player = audioplayer(aud, Fs);
play(player);
display("audioread done")

pause(2);

player = audioplayer(aud, Fs);
play(player);

%LP filtering
R = 1000; % Résistance en ohms
C = 3.97e-7; % Capacité en farads
y=LPfilter(R,C,aud,Fs);

y2=LPfilter(R,C,y,Fs);
y3=LPfilter(R,C,y2,Fs);
y4=LPfilter(R,C,y3,Fs);
y4=LPfilter(R,C,y4,Fs);


%etage ampli op
y4=y4*11;

%etage
y4=min(y4,1);
y4=max(y4,-1);

figure
  N = length(aud);
  t = linspace(0,N/Fs,N);
  hold on
  plot(t, aud, "b");
  plot(t, y4, "r");
  hold off


pause(4);
Fy = length(y2)*Fs/length(aud);

display("start playng final")
player2 = audioplayer(y4, Fy);
play(player2);
pause(1.3)
display("audioread end done")
