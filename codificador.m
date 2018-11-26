function [inputAudio] = codificador(inputFile, outfile, A_Mu, V, bitsPorBanda) 
  
  [inputAudio,fs] = audioread(inputFile);
  audioInfo = audioinfo(inputFile);
  TotalSamples = audioInfo.TotalSamples;

  bandas = separadorBandas(inputAudio, fs);

  codesPorBanda = zeros(4, 2^max(bitsPorBanda));

  todasBandasComprimidas = [];
  for(i = 1:4)

    bits = bitsPorBanda(i);
    bandaActual = bandas(i,:);
    
    bandaActual = compand(bandaActual, A_Mu, V, "A/compressor"); #Compresión dinámica
    %
    #Cuantización
    [partitions, codes] = lloyds(bandaActual,2^bits);  
    codesPorBanda(i,1:length(codes)) = codes;  
    [index,quants,distor] = quantiz(bandaActual,partitions,codes);  
       
    bandaComprimida = compresorTamano(index, bits);
    todasBandasComprimidas = horzcat(todasBandasComprimidas,bandaComprimida);
  endfor

  fid = fopen(outfile, "w+");
  fwrite(fid, fs, "uint32");
  fwrite(fid, TotalSamples, "uint32");
  fwrite(fid, V, "uint8");
  fwrite(fid, A_Mu, "uint8");
  fwrite(fid, bitsPorBanda, "uint8");
  %codesPorBanda
  for(i = 1:4)
    bits = bitsPorBanda(i);
    codesActual = codesPorBanda(i,:);
    fwrite(fid, codesActual(1:2^bits), "float32");  
  endfor
  fwrite(fid, todasBandasComprimidas, "uint8");
  fclose(fid);
  
#Se guardan en archivo #
endfunction