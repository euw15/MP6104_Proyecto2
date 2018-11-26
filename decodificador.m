function [bandaFinal] = decodificador(inputFile, outfile) 

  fid = fopen(inputFile, "r");
  fs = fread(fid, 1, "uint32");
  TotalSamples = fread(fid, 1, "uint32");
  V = fread(fid, 1, "uint8");
  A_Mu = fread(fid, 1, "uint8");
  bitsPorBanda = fread(fid, 4, "uint8")';
  codesPorBanda = zeros(4, 2^max(bitsPorBanda));
  for(i = 1:4)
    bits = bitsPorBanda(i);
    codesActual = fread(fid, 2^bits, "float32")'; 
    codesPorBanda(i,1:2^bits) = codesActual;
  endfor
  todasBandasComprimidas = fread(fid);
  fclose(fid);

  bandas = zeros(4, TotalSamples/4);
  fs = fs/4;
  offset = 0;
  for(i = 1:4)
    bits = bitsPorBanda(i);
    codesBandaActual = codesPorBanda(i,:);
    
    bandaActual = todasBandasComprimidas(1+offset : offset+ceil((TotalSamples/4)*bits/8));
    offset += length(bandaActual);
    bandaActual = descompresorTamano(bandaActual, bits, (TotalSamples/4));
    
    bandaActual = codesBandaActual(bandaActual+1); #Decuantización
    bandaActual = compand(bandaActual, A_Mu, V, "A/expander"); #Expansión dinámica
    
    bandas(i,:) = bandaActual;

  endfor

  bandaFinal = unidorBandas(bandas, fs);
  audiowrite(outfile, bandaFinal, fs*4,'BitsPerSample', 16);
  
endfunction