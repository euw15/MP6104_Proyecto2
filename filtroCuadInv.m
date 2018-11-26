
function [out] = filtroCuadInv(N, s1, s2, fs, plot = 0)
  
  TotalSamples = length(s1);
  newSamples = TotalSamples*2;
  newFs = fs * 2;
  b = mediaBandaBlackman(N);
  
  clear interpolated;
  j=1;
  for (i=1:(length(s1)*2))
    if (mod(i,2) == 0)
      interpolated(i) = s1(j);
      j = j+1;
    else
      interpolated(i) = 0;
    end
  end

  out1 = filter(b, 1, interpolated);

  if(plot)
    figure();
    stem(b);title("Media banda blackman");
    figure();
    freqz(b, 1);
    
    figure();
    stem(0:fs/TotalSamples:fs-fs/TotalSamples, abs(fft(s1)));
    title("Espectro señal 1 sin filtrar");
    
    figure();
    stem(0:newFs/newSamples:newFs-newFs/newSamples, abs(fft(out1)));
    title("Espectro señal 1 interpolada media banda inferior");
  endif
  
  bHP = b;
  %convertir filtro de LP a HP
  for(i=1:2:length(b))
    bHP(i) = -1 * b(i);
  end
  %bHP = -1 .* bHP;
  
  s2(1:2:TotalSamples)= -1.*s2(1:2:TotalSamples);
  
  clear interpolated;
  j=1;
  for (i=1:(length(s2)*2))
    if (mod(i,2) == 0)
      interpolated(i) = s2(j);
      j = j+1;
    else
      interpolated(i) = 0;
    end
  end
  
  out2 = filter(bHP, 1, interpolated);
  out = out1 + out2;
  
  if(plot)
    figure();
    freqz(bHP, 1);
    
    figure();
    stem(0:fs/TotalSamples:fs-fs/TotalSamples, abs(fft(s2)));
    title("Espectro señal 2 sin filtrar");
    
    figure();
    stem(0:newFs/newSamples:newFs-newFs/newSamples, abs(fft(out2)));
    title("Espectro señal 2 interpolada media banda superior");
    
    figure();
    stem(0:newFs/newSamples:newFs-newFs/newSamples, abs(fft(out)));
    title("Espectro señal restaurada");
  endif
  
 endfunction