function [b] = mediaBandaBlackman(N)
  wc = 0.5;

  m = floor(N*wc);
  Hd = zeros(2*N,1);
  Hd(N-m+1:N+m+1) = ones(2*m+1,1);

  Hd = fftshift(Hd);

  % Calcular hd(n) con la IDFT
  hd = fftshift(ifft(Hd));

  % Utilizar la parte real de hd(n) como el filtro FIR
  b = real(hd);
  b(2*N+1) = b(1);

  % Enventanar
  window = blackman(2*N+1);
  b = b .* window;
  
endfunction