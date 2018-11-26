function [b] = separadorBandas(inputAudio, fs)
  N = 159;
  
  [s1, s2] = filtroCuad(N, inputAudio, fs, 0);
  b = zeros(4, length(inputAudio)/4);
  
  [b(1,:), b(2,:)] = filtroCuad(N, s1, fs/2, 0);
  [b(3,:), b(4,:)] = filtroCuad(N, s2, fs/2, 0);
  
endfunction