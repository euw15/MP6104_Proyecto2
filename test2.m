close all;

[inputAudio, fs] = wavread('C:/Users/lopezgui/Desktop/Maestria/PDS/Proy 2/sonido16khz.wav');
%[inputAudio, fs] = wavread('C:/Users/lopezgui/Desktop/Maestria/PDS/Proy 2/sonido8khz.wav');
%[inputAudio, fs] = wavread('C:/Users/lopezgui/Desktop/Maestria/PDS/Proy 2/tone-ramp.wav');
%[inputAudio, fs] = wavread('C:/Users/lopezgui/Desktop/Maestria/PDS/Proy 2/recording8khz.wav');

%figure();
%stem(0:(fs-1), abs(fft(inputAudio, fs)));
%title(sprintf("Espectro señal muestreada a %d Hz", fs));
%break;

N = 159; %MSE -> 8.5916e-5
%N = 251; MSE -> 5.9788e-4
%N = 179; MSE -> 2.1393e-4
%N = 129; MSE -> 7.6788e-5
%N = 65; MSE -> 1.4029e-4
%N = 101; MSE -> 8.8217e-5
%N = 111; MSE -> 1.9486e-4

[s1, s2] = filtroCuad(N, inputAudio, fs, 0);

% --------------------------------------- %
%[s11, s12] = filtroCuad(N, s1, fs/2, 0);
%[s21, s22] = filtroCuad(N, s2, fs/2, 0);
%
%out1 = filtroCuadInv(N, s11, s12, fs/4, 0);
%out2 = filtroCuadInv(N, s21, s22, fs/4, 0);
% --------------------------------------- %

out = filtroCuadInv(N, s1, s2, fs/2, 0);
%out = filtroCuadInv(N, out1, out2, fs/2, 0);

%wavwrite(s1, fs/2, 'C:/Users/lopezgui/Desktop/Maestria/PDS/Proy 2/outputMediaBandaInf.wav');

%wavwrite(s2, fs/2, 'C:/Users/lopezgui/Desktop/Maestria/PDS/Proy 2/outputMediaBandaSup.wav');

%wavwrite(out, fs, 'C:/Users/lopezgui/Desktop/Maestria/PDS/Proy 2/recordingRestaurado.wav');
wavwrite(out, fs, 'C:/Users/lopezgui/Desktop/Maestria/PDS/Proy 2/outputRestaurado.wav');
break;
origDFT = fft(inputAudio);
restDFT = fft(out);
MSE = 0;
for(k=1:1:N-1)
  MSE += (abs(origDFT(k+1))-abs(restDFT(k+1)))^2;
end

MSE /= N;

break;
%==============================================================================%
% Pa diezmarsh
%==============================================================================%

N=169;
wc = 1/(24/3.5);%banda de paso hasta 3.5KHz
ws = 1/(24/4);%banda de rechazo a partir de 4KHz

b = remez(N, [0 wc ws 1], [1 1 0 0]);


figure();
freqz(b, 1);

%==============================================================================%
%==============================================================================%

%[inputAudio, fs] = wavread('C:/Users/lopezgui/Desktop/Maestria/PDS/Tarea 4/tone-ramp.wav');

figure();
stem(0:(fs-1), abs(fft(inputAudio, fs)));
title(sprintf("Espectro señal muestreada a %d Hz", fs));

filteredAudio = filter(b, 1, inputAudio);

figure();
stem(0:(fs-1), abs(fft(filteredAudio, fs)));
title("Espectro señal filtrada Remez");

clear decimatedAudio;
j=1;
for (i=1:6:length(filteredAudio))
  decimatedAudio(j) = filteredAudio(i);
  j = j+1;
end

fs = 8000;
wavwrite(decimatedAudio, fs, 'C:/Users/lopezgui/Desktop/Maestria/PDS/Proy 2/recording8khz.wav');
figure();
time=(1:length(decimatedAudio))/fs;
plot(time, decimatedAudio);
xlabel("tiempo (s)");
figure();
stem(0:(fs-1), abs(fft(decimatedAudio, fs)));
title("Espectro señal decimada Remez");