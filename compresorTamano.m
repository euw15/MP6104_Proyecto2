function [compDatos] = compresorTamano(datos, bitPorDato)
  offset=0;
  counter = 1;
  compDatos = zeros(1,ceil(length(datos)*bitPorDato/8));
  for(i = 1:length(datos))
    val = datos(i);
    valShifted = bitshift(val,8-bitPorDato-offset);
    compDatos(counter) = bitor(compDatos(counter), valShifted);
    offset += bitPorDato;
    if(offset>=8)
      counter++;
      offset -=8;
    endif
    if(offset!=0)
      valShifted = bitshift(val,8-offset);
      valShifted = bitor(compDatos(counter), valShifted);
      compDatos(counter) = bitand(valShifted, 0xFF);
    endif
  endfor  
endfunction