function [descompDatos] = descompresorTamano(datos, bitPorDato, totalDatos)
  descompDatos = zeros(1,totalDatos);
  
  offset=0;
  counter = 1;
  mask = 2^bitPorDato - 1;
  
  for(i = 1:length(descompDatos))
    valActual = datos(counter);
    valFinal = bitshift(valActual,bitPorDato+offset-8);
    offset += bitPorDato;
    
    if(offset>=8)
      counter++;
      offset-=8;
    endif
    if(offset!=0)      
      valActual = datos(counter); 
      valActual = bitshift(valActual,offset-8);
      
      valFinal = bitor(valFinal, valActual);
    endif
    valFinal = bitand(valFinal, mask);
    descompDatos(i) = valFinal;
  endfor 
endfunction