function [out] = unidorBandas(bandas, fs)
  N = 159;
  
  subBandaBaja = filtroCuadInv(N, bandas(1,:), bandas(2,:), fs, 0);
  subBandaAlta = filtroCuadInv(N, bandas(3,:), bandas(4,:), fs, 0);
  
  out = filtroCuadInv(N, subBandaBaja, subBandaAlta, fs*2, 0);
endfunction