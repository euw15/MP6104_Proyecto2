% Función para graficar polos y ceros en el círclo unitario
% Por Juan Carlos Rojas

function plot_poles_zeros(b, a)

  figure();

  % Calcular los polos y ceros
  p = roots(a);
  z = roots(b);

  % Dibujar el círculo unitario
  wstep = 2*pi/100;
  wrange = 0:wstep:2*pi;
  circle = exp(j*wrange);
  plot(circle);
  axis([-1.2 1.2 -1.2 1.2]);
  hold on;

  % Se agrega un número imaginario pequeño para facilitar su ubicación en el gráfico
  p = p + j*1e-16;
  z = z + j*1e-16;
  plot(p, 'xr');
  plot(z, 'or');

  return