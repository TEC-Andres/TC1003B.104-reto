clear; clc;

Px = [
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

Py = [
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

hold on; 
delta = 0.01;
x = [Px(1), Px(2), Px(3), Px(4), Px(5), Px(6), Px(7), Px(8), Px(9), Px(10), Px(11), Px(12), Px(13), Px(14)];
y = [Py(1), Py(2), Py(3), Py(4), Py(5), Py(6), Py(7), Py(8), Py(9), Py(10), Py(11), Py(12), Py(13), Py(14)];
xALL = Px(1):delta:Px(14);
yALL = spline(x,y,xALL);

x1 = Px(1):delta:Px(3);
y1 = spline(x,y,x1);

x2 = Px(3):delta:Px(5);
y2 = spline(x,y,x2);

x3 = Px(5):delta:Px(7);
y3 = spline(x,y,x3);

x4 = Px(7):delta:Px(8);
y4 = spline(x,y,x4);

x5 = Px(8):delta:Px(10);
y5 = spline(x,y,x5);

x6 = Px(10):delta:Px(12);
y6 = spline(x,y,x6);

x7 = Px(12):delta:Px(14);
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

% PLOT 3D 
subplot(1, 2, 2);

xlim([0 6.5]);
ylim([0 2.5]);


cylinder(yALL);