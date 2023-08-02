% Fonction pour générer le signal composé de 3 sinusoïdes
clear all
clf
clear figure
close all

% Fonction pour générer le signal composé de 3 sinusoïdes
function [signal,s1,s2,s3] = generate_signal(freq1, freq2, freq3, amplitude1, amplitude2, amplitude3, duration, sampling_rate)
    t = linspace(0, duration, duration * sampling_rate);

    s1= amplitude1 * sin(2 * pi * freq1 * t);
    s2= amplitude2 * sin(2 * pi * freq2 * t);
    s3 = amplitude3 * sin(2 * pi * freq3 * t);
    signal = s1 + s2 + s3;
endfunction

% Fonction pour appliquer le filtre passe-bas
function filtered_signal = low_pass_filter(signal, R, C, sampling_rate)
    dt = 1 / sampling_rate;
    alpha = dt / (R * C + dt);
    filtered_signal = zeros(size(signal));
    filtered_signal(1) = signal(1);
    for i = 2:length(signal)
        filtered_signal(i) = alpha * signal(i) + (1 - alpha) * filtered_signal(i - 1);
    end
endfunction

% Paramètres du signal et du filtre
sampling_rate = 1000;  % Taux d'échantillonnage en Hz
duration = 2;          % Durée du signal en secondes

freq1 = 100;             % Fréquence de la première sinusoïde en Hz
freq2 = 5000;            % Fréquence de la deuxième sinusoïde en Hz
freq3 = 10000;            % Fréquence de la troisième sinusoïde en Hz

amplitude1 = 1;        % Amplitude de la première sinusoïde
amplitude2 = 1;      % Amplitude de la deuxième sinusoïde
amplitude3 = 1;      % Amplitude de la troisième sinusoïde

% Générer le signal composé de 3 sinusoïdes
[signal,s1,s2,s3] = generate_signal(freq1, freq2, freq3, amplitude1, amplitude2, amplitude3, duration, sampling_rate);

% Afficher les signaux d'origine séparément
t = linspace(0, duration, duration * sampling_rate);



% Définir les valeurs de R et C à tester
R_values = [10, 1000, 10000];  % Valeurs de R en ohms
C_values = [1e-5];  % Valeurs de C en farads

% Appliquer le filtre passe-bas pour chaque combinaison de R et C
for R = R_values
    for C = C_values
        % Appliquer le filtre
        filtered_signal = low_pass_filter(signal, R, C, sampling_rate);

        % Afficher les résultats
        figure;
        subplot(2, 1, 1);
        plot(t, s1, 'b', 'linewidth', 1.5);
        hold on;
        plot(t, s2, 'g', 'linewidth', 1.5);
        plot(t, s3, 'c', 'linewidth', 1.5);

        plot(t, filtered_signal, 'r', 'linewidth', 1);
        xlabel('Temps (s)');
        ylabel('Amplitude');
        title(['Filtre passe-bas avec R = ', num2str(R), ' ohms, C = ', num2str(C), ' farads']);
        legend({'Signal dorigine 1','Signal dorigine 2','Signal dorigine 3', 'Signal filtré'});
        grid on;
        hold off;

        % Calculer et afficher les spectres fréquentiels
        L = length(signal);
        f = logspace(1,log(L/2),L/2);
        signal_fft = fft(signal);
        filtered_signal_fft = fft(filtered_signal);

        subplot(2, 1, 2);
        semilogx(f, abs(signal_fft(1:L/2)), 'b', 'linewidth', 1.5);
        hold on;
        semilogx(f, abs(filtered_signal_fft(1:L/2)), 'r', 'linewidth', 1.5);
        xlabel('Fréquence (Hz)');
        ylabel('Amplitude');
        title('Spectre fréquentiel');
        axis([10 1000]);
        legend({'Spectre du signal d''origine', 'Spectre du signal filtré'});
        grid on;
        hold off;
    end
end

