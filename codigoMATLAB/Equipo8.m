% Equipo8.m
% Modelo 2D y 3D de un portavasos para su impresión 3D. Contiene el
% cálculo del volumen y masa del portavasos, así como el costo de producción
% basado en el peso del material utilizado (PLA)-
% Integrantes: Alexa Martinez Escobedo — A00846107, Andrés Rodríguez Cantú — A01287002,
% Viviana González Cervantes — A01572270

clear; clf; clc;
%puntos en x
Px = [
    0.00000000000000;
    0.02829384143869;
    1.12438058710880;
    2.34647517130020;
    3.48843240570850;
    4.69049265245410;
    6.39341133534370;
    7.02021222699750;
    7.25711706852100;
    7.53645262792920;
    8.00000000000000;
    8.50565163089840;
    9.17156151452510;
    9.79830022852660;
    10.6013092058411;
    11.1301199957799;
    11.5022461072183;
    12.0702280667822;
    12.5794532719084;
    13.2453631555351;
];


%puntos Y
Py = [
    0.0000000000000;
    5.3987521943738;
    5.9597136428551;
    6.0398509926382;
    6.0199883424212;
    6.0199883424212;
    6.0999540049755;
    6.3384842998871;
    6.9112989913319;
    7.4381470717348;
    8.0121000000000;
    7.9121857971254;
    7.9121857971254;
    7.9121857971254;
    7.9121000000000;
    8.1863839845010;
    8.5172668503771;
    8.5172600000000;
    8.5170000000000;
    8.5170000000000;
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
y = [Py(10), Py(11), Py(12), Py(13)];
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

%plot(x1, y1, 'r', 'LineWidth',3)
%plot(x2, y2, 'm', 'LineWidth',3)
%plot(x3, y3, 'c', 'LineWidth',3)
%plot(x4, y4, 'k', 'LineWidth',3)
%plot(x5, y5, 'r', 'LineWidth',3)
%plot(x6, y6, 'y', 'LineWidth',3)
%plot(x7, y7, 'y', 'LineWidth',3)

X = [x1, x2, x3, x4, x5, x6, x7];
Y = [y1, y2, y3, y4, y5, y6, y7];

xMin = min(X);
xMax = max(X);
yMin = min(Y);
yMax = max(Y);

%grafica 2d
subplot(1, 2, 1)
plot(X, Y, 'r', 'LineWidth', 3)
xlim([0 15])
ylim([0 15])
camroll(90)

%grafica 3d
% Gráfica 3D creada a partir 
subplot(1, 2, 2)
hold on
theta = linspace(0, 2*pi, 72);
[thetaGridOuter, xGridOuter] = meshgrid(theta, X);
radiusGridOuter = repmat(Y(:), 1, numel(theta));
% rotate so axis of revolution aligns with Z: axial coordinate = X
newXOuter = radiusGridOuter .* cos(thetaGridOuter);
newYOuter = radiusGridOuter .* sin(thetaGridOuter);
newZOuter = xGridOuter;
surf(newXOuter, newYOuter, newZOuter, ...
    'FaceColor', [1 0 0], ...
    'FaceAlpha', 0.3, ...
    'EdgeColor', 'none');
view(3)
axis equal
% after rotation, axial limits go on Z
xlim([-yMax yMax])
ylim([-yMax yMax])
zlim([xMin xMax])
xlabel('x')
ylabel('y')
zlabel('z')
grid on




%%%%%%%%%%%%%%%%%%%%%%%%%%%%parte 4



%obtener coeficientes 
P1 = vander(Px(1:2)) \ Py(1:2);
P2 = vander(Px(2:7)) \ Py(2:7);
P3 = vander(Px(7:9)) \ Py(7:9);
P4 = vander(Px(9:10)) \ Py(9:10);
P5 = vander(Px(10:13)) \ Py(10:13);
P6 = vander(Px(13:16)) \ Py(13:16);
P7 = vander(Px(16:20)) \ Py(16:20);


%crear funciones con los coeficientes
f1 = @(x) pi*(P1(1)*x+P1(2)).^2; 
f2 = @(x) pi*(P2(1)*x.^5 + P2(2)*x.^4 + P2(3)*x.^3 + P2(4)*x.^2 + P2(5)*x + P2(6)).^2; 
f3 = @(x) pi*(P3(1)*x.^2 + P3(2)*x + P3(3)).^2;
f4 = @(x) pi*(P4(1)*x+P4(2)).^2; 
f5 = @(x) pi*(P5(1)*x.^3 + P5(2)*x.^2 + P5(3)*x + P5(4)).^2;
f6 =  @(x) pi*(P6(1)*x.^3 + P6(2)*x.^2 + P6(3)*x + P6(4)).^2;
f7 = @(x) pi *(P7(1)*x.^4 + P7(2)*x.^3 + P7(3)*x.^2 + P7(4)*x + P7(5)).^2;


v1 = integral(f1, Px(1), Px(2));
v2 = integral(f2, Px(2), Px(7));
v3 = integral(f3, Px(7), Px(9));
v4 = integral(f4, Px(9), Px(10));
v5 = integral(f5, Px(10), Px(13));
v6 = integral(f6, Px(13), Px(16));
v7 = integral(f7, Px(16), Px(20));

vt = v1 + v2 + v3 + v4 + v5 +v6+v7;
% disp("El volumen total es: " + vt + " cm^3")

%densidad del acero inoxidable 
densidad = 1.25; %g/cm^3

%masa de afuera
masa = vt * densidad;
% disp("La masa total del florero es " + masa + " gramos")

%masa en kg
masaEnKg = masa/1000;
% disp("Masa en kg: "+ masaEnKg)




%%%%%%%%%%%%PARTE INTERNA

PDx = [
    1.12300000000000;
    1.12438058710880;
    2.34647517130020;
    3.48843240570850;
    4.69049265245410;
    6.39341133534370;
    6.93399925442280;
    7.31119886263940;
    7.53516113001800;
    8.04791684743750;
    8.50000000000000;
    9.09110951391170;
    9.75411585882000;
    10.6013092058411;
    11.1660280399948;
    11.4936629577973;
    12.1079784286769;
    12.6403851701060;
    13.2137462762604;
];


PDy = [
    0.0000000000000; 
    4.9597136428551;
    5.0398509926382;
    5.0199883424212;
    5.0199883424212;
    5.0999540049755;
    5.3508500413040;
    5.8518182709667;
    6.3233177812375;
    6.8301797547786;
    7.0000000000000;
    6.9834170956167;
    6.9390003916599;
    7.0121000000000;
    7.2034894775654;
    7.6130331248185;
    7.6130331248185;
    7.6130331248185;
    7.6232717159998;
];


hold on
delta = 0.01;

%función delta 1
x = [PDx(1), PDx(2)];
y = [PDy(1), PDy(2)];
xD0= PDx(1) : delta : PDx(2);
yD0= spline(x, y, xD0);

%función delta 2 
x = [PDx(2), PDx(3), PDx(4), PDx(5), PDx(6)];
y = [PDy(2), PDy(3), PDy(4), PDy(5), PDy(6)];
xD1= PDx(2) : delta : PDx(6);
yD1= spline(x, y, xD1);

%función delta 3 
x = [PDx(6), PDx(7), PDx(8)];
y = [PDy(6), PDy(7), PDy(8)];
xD2= PDx(6) : delta : PDx(8);
yD2= spline(x, y, xD2);

%función delta 4 
x = [PDx(8), PDx(9)];
y = [PDy(8), PDy(9)];
xD3= PDx(8) : delta : PDx(9);
yD3= spline(x, y, xD3);

%función delta 5 
x = [PDx(9), PDx(10), PDx(11), PDx(12)];
y = [PDy(9), PDy(10), PDy(11), PDy(12)];
xD4= PDx(9) : delta : PDx(12);
yD4= spline(x, y, xD4);


%función delta 6
x = [PDx(12), PDx(13), PDx(14), PDx(15)];
y = [PDy(12), PDy(13), PDy(14), PDy(15)];
xD5= PDx(12) : delta : PDx(15);
yD5= spline(x, y, xD5);


%función delta 7
x = [PDx(15), PDx(16), PDx(17), PDx(18), PDx(19)];
y = [PDy(15), PDy(16), PDy(17), PDy(18), PDy(19)];
xD6= PDx(15) : delta : PDx(19);
yD6= spline(x, y, xD6);



%plot(xD1, yD1, 'r', 'LineWidth',3)
%plot(xD2, yD2, 'm', 'LineWidth',3)
%plot(xD3, yD3, 'c', 'LineWidth',3)
%plot(xD4, yD4, 'k', 'LineWidth',3)
%plot(xD5, yD5, 'r', 'LineWidth',3)
%plot(xD6, yD6, 'y', 'LineWidth',3)


XD = [xD0, xD1, xD2, xD3, xD4, xD5, xD6];
YD = [yD0, yD1, yD2, yD3, yD4, yD5, yD6];

xMin = min([xMin, XD]);
xMax = max([xMax, XD]);
yMin = min([yMin, YD]);
yMax = max([yMax, YD]);

%grafica 2d
subplot(1, 2, 1)
hold on
plot(XD, YD, 'y', 'LineWidth', 3)
xlim([0 15])
ylim([0 15])
% camroll(90)

%grafica 3d
subplot(1, 2, 2)
[thetaGridInner, xGridInner] = meshgrid(theta, XD);
radiusGridInner = repmat(YD(:), 1, numel(theta));
newXInner = radiusGridInner .* cos(thetaGridInner);
newYInner = radiusGridInner .* sin(thetaGridInner);
newZInner = xGridInner;
surf(newXInner, newYInner, newZInner, ...
    'FaceColor', [1 1 0], ...
    'FaceAlpha', 0.3, ...
    'EdgeColor', 'none');
view(3)
axis equal
% keep same shared limits after rotation
xlim([-yMax yMax])
ylim([-yMax yMax])
zlim([xMin xMax])
xlabel('x')
ylabel('y')
zlabel('z')
grid on



%obtener coeficientes 
PD0 = vander(PDx(1:2)) \ PDy(1:2);
PD1 = vander(PDx(2:6)) \ PDy(2:6);
PD2 = vander(PDx(6:8)) \ PDy(6:8);
PD3 = vander(PDx(8:9)) \ PDy(8:9);
PD4 = vander(PDx(9:12)) \ PDy(9:12);
PD5 = vander(PDx(12:15)) \ PDy(12:15);
PD6 = vander(PDx(15:19)) \ PDy(15:19);


%crear funciones con los coeficientes
fD0 = @(x) pi*(PD0(1)*x+PD0(2)).^2;
fD1 = @(x) pi*(PD1(1)*x.^4 + PD1(2)*x.^3 + PD1(3)*x.^2 + PD1(4)*x + PD1(5)).^2;
fD2 = @(x) pi*(PD2(1)*x.^2 + PD2(2)*x + PD2(3)).^2; 
fD3 = @(x) pi*(PD3(1)*x+PD3(2)).^2; 
fD4 = @(x) pi*(PD4(1)*x.^3 + PD4(2)*x.^2 + PD4(3)*x + PD4(4)).^2;
fD5 = @(x) pi*(PD5(1)*x.^3 + PD5(2)*x.^2 + PD5(3)*x + PD5(4)).^2;
fD6 = @(x) pi*(PD6(1)*x.^4 + PD6(2)*x.^3 + PD6(3)*x.^2 + PD6(4)*x + PD6(5)).^2;


vD0 = integral(fD0, PDx(1), PDx(2));
vD1 = integral(fD1, PDx(2), PDx(6));
vD2 = integral(fD2, PDx(6), PDx(8));
vD3 = integral(fD3, PDx(8), PDx(9));
vD4 = integral(fD4, PDx(9), PDx(12));
vD5 = integral(fD5, PDx(12), PDx(15));
vD6 = integral(fD6, PDx(15), PDx(19));


vDt = vD0 + vD1 + vD2 + vD3 + vD4 + vD5 + vD6;


%disp("El volumen DELTA total es: " + vDt + " cm^3")

%densidad del PLA
densidad = 1.25; %g/cm^3

%masa
masaD = vDt * densidad;
%disp("La masa total del florero es " + masa2 + " gramos")

%masa en kg
masaDEnKg = masaD/1000;
%disp("Masa en kg: "+ masaEnKg2)

%precio y costo total
precio = 200; 
costo2 = precio * masaDEnKg;

%disp("El costo total del florero es de: $" + costo2)


vResultante = vt - vDt;
masaResultante = masaEnKg - masaDEnKg;
disp("volumen resultante: "+vResultante + "cm^3")
disp("masa resultante: " +masaResultante + " kg")
costoR = precio * masaResultante;
disp("costo final: $"+costoR)