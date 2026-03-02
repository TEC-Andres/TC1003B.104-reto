%puntos X
Px = [0.102; %C- 1
    0.282; %D- 2
    1.124; %E - 3
    2.346; %F - 4
    3.488; %G - 5
    4.690; %H - 6
    6.393; %I - 7
    6.977; %J - 8
    7.232; %K - 9
    7.526; %L - 10
    8; %M - 11
    8.505; %N - 12
    9.171; %O- 13
    9.798; %P- 14
    10.60; %Q-15
    11.13; %R - 16
    11.502; %S - 17
    12.0702; %T- 18
    12.579; %U - 19
    13.245 %V - 20
    ];


%puntos Y
Py = [4.497; %C- 1
    5.398; %D- 2
    5.959; %E - 3
    6.039; %F - 4
    6.0199; %G - 5
    6.0199; %H - 6
    6.0999; %I - 7
    6.445; %J - 8
    7.052; %K - 9
    7.6; %L - 10
    8.0121; %M - 11
    8.0121; %N - 12
    8.0121; %O- 13
    8.0121; %P- 14
    8.0121; %Q-15
    8.286; %R - 16
    8.717; %S - 17
    8.717; %T- 18
    8.717; %U - 19
    8.717 %V - 20
    ];

hold on
delta = 0.01;

%función 1 fx
x = [Px(1), Px(2)];
y = [Py(1), Py(2)];
x1= Px(1) : delta : Px(2);
y1= spline(x, y, x1);

%función 2 gx
x = [Px(2), Px(3), Px(4), Px(5), Px(6), Px(7)];
y = [Py(2), Py(3), Py(4), Py(5), Py(6), Py(7)];
x2= Px(2) : delta : Px(7);
y2= spline(x, y, x2);

%función 3 hx
x = [Px(7), Px(8), Px(9)];
y = [Py(7), Py(8), Py(9)];
x3= Px(7) : delta : Px(9);
y3= spline(x, y, x3);

%función 4 px
x = [Px(9), Px(10)];
y = [Py(9), Py(10)];
x4= Px(9) : delta : Px(10);
y4= spline(x, y, x4);

%función 5 qx
x = [Px(10), Px(11), Px(12), Px(13)];
y = [Py(10), Py(11), Py(12), Py(13)]; % ERROR ACA
x5= Px(10) : delta : Px(13);
y5= spline(x, y, x5);

%función 6 rx
x = [Px(13), Px(14), Px(15), Px(16)];
y = [Py(13), Py(14), Py(15), Py(16)];
x6= Px(13) : delta : Px(16);
y6= spline(x, y, x6);

%función 7 sx
x = [Px(16), Px(17), Px(18), Px(19), Px(20)];
y = [Py(16), Py(17), Py(18), Py(19), Py(20)];
x7= Px(16) : delta : Px(20);
y7= spline(x, y, x7);

plot(x1, y1, 'r', 'LineWidth',3)
plot(x2, y2, 'm', 'LineWidth',3)
plot(x3, y3, 'c', 'LineWidth',3)
plot(x4, y4, 'k', 'LineWidth',3)
plot(x5, y5, 'r', 'LineWidth',3)
plot(x6, y6, 'y', 'LineWidth',3)
plot(x7, y7, 'y', 'LineWidth',3)

X = [x1, x2, x3, x4, x5, x6, x7];
Y = [y1, y2, y3, y4, y5, y6, y7]; % ERROR ACA

%grafica 2d
subplot(1, 2, 1)
plot(X, Y, 'r', 'LineWidth', 3)
xlim([0 15])
ylim([0 15])
camroll(90)

%grafica 3d
subplot(1, 2, 2)
cylinder(Y)

