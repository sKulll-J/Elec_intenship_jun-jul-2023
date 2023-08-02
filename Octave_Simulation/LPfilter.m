function y=LPfilter (R,C, aud, Fs)
  figure
  newSize=length(aud);
  aud=aud(1:round(length(aud)/newSize):end);

  N = length(aud);
  mN = round(N/2);
  t = linspace(0,N/Fs,N);



  AUD = abs(fft(aud))/double(mN);
  AUD=fftshift(AUD);
  f = (1:mN)*(Fs/N);
  miAUD=AUD(mN+1:length(AUD));

  H = tf(1, [R*C, 1]); % Fonction de transfert du filtre passe-bas RC

  % Simulation de la réponse du filtre au signal d'entrée
  y = lsim(H, aud, t); % Signal de sortie

  % affichage de sortie

  N = length(y);
  mN = round(N/2);
  t = linspace(0,N/Fs,N);

  gain = 1;

  y=gain*y;

  subplot(2,1,1);
  hold on
  plot(t, aud, "b");
  plot(t, y, "r");

  hold off


  %___plot frequency
  subplot(2,1,2)
  Y = abs(fft(y))/double(mN);
  Y=fftshift(Y);
  f = (1:mN)*(Fs/N);
  miY=Y(mN+1:end);
  %__filtre apearance
  %h=1./(1.+R*C*2*pi.*f);

hold on
  %semilogx(f, h(mN:end),"g");
  semilogx(f, miAUD,"b");
  semilogx(f,miY,"r");

axis([200,20000])
grid on

hold off

  endfunction
