% andresRodriguez.m
% Hace un sólido de revolución a partir de la curva dada por un array de puntos. Se crea creará dos figuras, una en 2D y la otra en 3D.
% Andrés Rodríguez Cantú
clear; clc;

GROSOR = 0.4;
DENSIDADVIDRIO = 2.5; % g/cm^3

POriginalX = [
    0.0000000000000; % Cx
    0.0515357772680; % Dx
    0.3439711588273; % Ex
    0.5080930566412; % Fx
    0.6811670579721; % Gx
    1.2011478129278; % Hx
    2.4876823553471; % Ix
    4.5567935652025; % Jx
    5.0173568921342; % Kx
    5.3982073355585; % Lx
    5.9207695718849; % Mx
    6.3104770023656; % Nx
    6.4344748211550; % Ox
    6.5319016787751; % Px
];

POriginalY = [
    0.0000000000000; % Cy
    0.2892149394660; % Dy
    1.0561118074327; % Ey
    1.2306778260165; % Fy
    1.3052786886592; % Gy
    1.9549928697846; % Hy
    2.2797191365011; % Iy
    1.4095374520525; % Jy
    1.2146837368122; % Ky
    1.1703988015303; % Ly
    1.2058267497558; % My
    1.3741095038270; % Ny
    1.2545401785659; % Oy
    1.1039713986074; % Py
];

% PDELTAY
PDeltaY = POriginalY - GROSOR;

hold on; 
delta = 0.01;
x = [POriginalX(1), POriginalX(2), POriginalX(3), POriginalX(4), POriginalX(5), POriginalX(6), POriginalX(7), POriginalX(8), POriginalX(9), POriginalX(10), POriginalX(11), POriginalX(12), POriginalX(13), POriginalX(14)];
y = [POriginalY(1), POriginalY(2), POriginalY(3), POriginalY(4), POriginalY(5), POriginalY(6), POriginalY(7), POriginalY(8), POriginalY(9), POriginalY(10), POriginalY(11), POriginalY(12), POriginalY(13), POriginalY(14)];
xALL = POriginalX(1):delta:POriginalX(14);
yALL = spline(x,y,xALL);

x1 = POriginalX(1):delta:POriginalX(3);
y1 = spline(x,y,x1);

x2 = POriginalX(3):delta:POriginalX(5);
y2 = spline(x,y,x2);

x3 = POriginalX(5):delta:POriginalX(7);
y3 = spline(x,y,x3);

x4 = POriginalX(7):delta:POriginalX(8);
y4 = spline(x,y,x4);

x5 = POriginalX(8):delta:POriginalX(10);
y5 = spline(x,y,x5);

x6 = POriginalX(10):delta:POriginalX(12);
y6 = spline(x,y,x6);

x7 = POriginalX(12):delta:POriginalX(14);
y7 = spline(x,y,x7);

% PLOT 2D
subplot(1,2,1);
hold on;
plot(x1, y1, 'r', 'LineWidth', 3);
plot(x2, y2, 'g', 'LineWidth', 3);
plot(x3, y3, 'b', 'LineWidth', 3);
plot(x4, y4, 'c', 'LineWidth', 3);
plot(x5, y5, 'k', 'LineWidth', 3);
plot(x6, y6, 'm', 'LineWidth', 3);
plot(x7, y7, 'w', 'LineWidth', 3);
xlim([0 6.5]);
ylim([0 2.5]);
camroll(90);
hold off;

% PLOT 2D DELTA
subplot(1,2,1);
hold on;
plot(xALL, spline(x,PDeltaY,xALL), '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.5);
% rellenar área entre original y desplazada para visualizar grosor
yy1 = yALL;
yy2 = spline(x,PDeltaY,xALL);
fill([xALL, fliplr(xALL)], [yy1, fliplr(yy2)], [0.8 0.8 1], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
xlim([0 6.5]);
ylim([0 2.5]);
hold off;

% PLOT 3D 
subplot(1, 2, 2);
xlim([0 6.5]);
ylim([0 2.5]);
cylinder(yALL);
% colorear el cilindro resultante de la revolución en amarillo con 30% de opacidad
h = findobj(gca, 'Type', 'surface'); 
if ~isempty(h)
    for k = 1:numel(h)
        set(h(k), ...
            'FaceColor', [1 1 0], ...
            'FaceAlpha', 0.3, ...
            'EdgeColor', 'none');
    end
end

% PLOT 3D DELTA
subplot(1, 2, 2);
hold on;
hBefore = findobj(gca, 'Type', 'surface');
cylinder(spline(x, PDeltaY, xALL));
hAll = findobj(gca, 'Type', 'surface');
hDelta = setdiff(hAll, hBefore); 
if ~isempty(hDelta)
    for k = 1:numel(hDelta)
        set(hDelta(k), ...
            'FaceColor', [0 0.8 1], ...
            'FaceAlpha', 0.6, ...
            'EdgeColor', [0 0.5 0.7], ... 
            'LineWidth', 0.5);
    end
end


% Ecuaciones de puntos originales
P1 = vander(POriginalX(1:3))\POriginalY(1:3);
P2 = vander(POriginalX(3:5))\POriginalY(3:5);
P3 = vander(POriginalX(5:7))\POriginalY(5:7);
P4 = vander(POriginalX(7:8))\POriginalY(7:8);
P5 = vander(POriginalX(8:10))\POriginalY(8:10);
P6 = vander(POriginalX(10:12))\POriginalY(10:12);
P7 = vander(POriginalX(12:14))\POriginalY(12:14);
f1 = @(x) pi*((P1(1)*x.^2 + P1(2)*x + P1(3)).^2);
f2 = @(x) pi*((P2(1)*x.^2 + P2(2)*x + P2(3)).^2);
f3 = @(x) pi*((P3(1)*x.^2 + P3(2)*x + P3(3)).^2);
f4 = @(x) pi*((P4(1)*x + P4(2)).^2);
f5 = @(x) pi*((P5(1)*x.^2 + P5(2)*x + P5(3)).^2);
f6 = @(x) pi*((P6(1)*x.^2 + P6(2)*x + P6(3)).^2);
f7 = @(x) pi*((P7(1)*x.^2 + P7(2)*x + P7(3)).^2);
v1 = integral(f1, POriginalX(1), POriginalX(3));
v2 = integral(f2, POriginalX(3), POriginalX(5));
v3 = integral(f3, POriginalX(5), POriginalX(7));
v4 = integral(f4, POriginalX(7), POriginalX(8));
v5 = integral(f5, POriginalX(8), POriginalX(10));
v6 = integral(f6, POriginalX(10), POriginalX(12));
v7 = integral(f7, POriginalX(12), POriginalX(14));

VOriginal = v1 + v2 + v3 + v4 + v5 + v6 + v7;

% Ecuaciones del desfase
P1 = vander(POriginalX(1:3))\PDeltaY(1:3);
P2 = vander(POriginalX(3:5))\PDeltaY(3:5);
P3 = vander(POriginalX(5:7))\PDeltaY(5:7);
P4 = vander(POriginalX(7:8))\PDeltaY(7:8);
P5 = vander(POriginalX(8:10))\PDeltaY(8:10);
P6 = vander(POriginalX(10:12))\PDeltaY(10:12);
P7 = vander(POriginalX(12:14))\PDeltaY(12:14);
f1 = @(x) pi*((P1(1)*x.^2 + P1(2)*x + P1(3)).^2);
f2 = @(x) pi*((P2(1)*x.^2 + P2(2)*x + P2(3)).^2);
f3 = @(x) pi*((P3(1)*x.^2 + P3(2)*x + P3(3)).^2);
f4 = @(x) pi*((P4(1)*x + P4(2)).^2);
f5 = @(x) pi*((P5(1)*x.^2 + P5(2)*x + P5(3)).^2);
f6 = @(x) pi*((P6(1)*x.^2 + P6(2)*x + P6(3)).^2);
f7 = @(x) pi*((P7(1)*x.^2 + P7(2)*x + P7(3)).^2);
v1 = integral(f1, POriginalX(1), POriginalX(3));
v2 = integral(f2, POriginalX(3), POriginalX(5));
v3 = integral(f3, POriginalX(5), POriginalX(7));
v4 = integral(f4, POriginalX(7), POriginalX(8));
v5 = integral(f5, POriginalX(8), POriginalX(10));
v6 = integral(f6, POriginalX(10), POriginalX(12));
v7 = integral(f7, POriginalX(12), POriginalX(14));

VDelta = v1 + v2 + v3 + v4 + v5 + v6 + v7;
VTotal = VOriginal-VDelta;
masa = DENSIDADVIDRIO*VTotal;

fprintf('El volúmen de nuestro objeto es %.4f cm^3\nY la masa es %.4f g\n', VTotal, masa);
