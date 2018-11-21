
function [s1, s2] = filtroCuad(N, input, fs, plot = 0)
  
  b = mediaBandaBlackman(N);

  s1 = filter(b, 1, input);
  
  clear decimated;
  j=1;
  for (i=1:2:length(s1))
    decimated(j) = s1(i);
    j = j+1;
  end
  
  s1 = 2 .* decimated;
  
  if(plot)
    figure();
    stem(b);title("Media banda blackman");
    figure();
    freqz(b, 1);
    
    figure();
    stem(0:(fs-1), abs(fft(input, fs)));
    title("Espectro señal sin filtrar");
    
    figure();
    stem(0:(fs-1), abs(fft(s1, fs)));
    title("Espectro señal decimada media banda inferior");
  endif
  
  bHP = b;
  %convertir filtro de LP a HP
  for(i=1:2:length(b))
    bHP(i) = -1 * b(i);
  end
  
  s2 = filter(bHP, 1, input);
  
  clear decimated;
  j=1;
  for (i=1:2:length(s2))
    decimated(j) = s2(i);
    j = j+1;
  end
  
  s2 = 2 .* decimated;
  
  %obtener reflexion
%  for(i=1:2:length(s2))
%    s2(i) = -s2(i);
%  end
  
  if(plot)
    figure();
    freqz(bHP, 1);
    
    figure();
    stem(0:(fs-1), abs(fft(s2, fs)));
    title("Espectro señal filtrada media banda superior");
  endif
  
 endfunction