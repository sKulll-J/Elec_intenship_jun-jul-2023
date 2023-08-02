function y=HPfilter (R,C, aud, Fs)
  figure
  newSize=length(aud);
  ad=aud(1:round(length(aud)/newSize):end);

  display(length(ad));
  N = length(ad);
  mN = round(N/2);
  t = linspace(0,N/Fs,N);

  fc=1/(R*C)

  AD = abs(fft(ad))/double(mN);
  AD=fftshift(AD);
  f = (1:mN)*(Fs/N);
  miAD=AD(mN:length(AD));

  H = tf(R*C, [R*C, 1]); % Fonction de transfert du filtre passe-bas RC

  % Simulation de la réponse du filtre au signal d'entrée
  y = lsim(H, ad, t); % Signal de sortie

  % affichage de sortieR

  gain = 1 ;

  y=gain*y;

  subplot(2,1,1);
  hold on
  plot(t, ad, "b");
  plot(t, y, "r");

  hold off


  %___plot frequency
  subplot(2,1,2)
  Y = abs(fft(y))/double(mN);
  Y=fftshift(Y);
  f = (1:mN)*(Fs/N);
  miY=Y(mN:length(ad));


  %__filtre apearance
  %h=1./(1.+R*C*2*pi.*f);

hold on
  %semilogx(f, h(mN:end),"g");
  semilogx(f, abs(miAD),"b");
  semilogx(f,abs(miY),"r");

axis([200,25000])
grid on

hold off

  endfunction
