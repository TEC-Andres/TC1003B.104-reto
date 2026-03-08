%Alexa Martínez Escobedo A00884107
%Código de florero
clear
clc

%puntos X
Px = [0; %C- 1
    0.0312; %D- 2
    0.13089; %E - 3
    0.39961; %F - 4
    0.8; %G - 5
    1.8; %H - 6
    2.50263; %I - 7
    3.43357; %J - 8
    4.00217; %K - 9
    4.50388; %L - 10
    4.99444; %M - 11
    5.38466; %N - 12
    5.65224; %O- 13
    5.94769; %P- 14
    6.06475 %Q-15
    ];


%puntos Y
Py = [0; %C- 1
    0.60169; %D- 2
    1.00081; %E - 3
    1.26177; %F - 4
    1.4; %G - 5
    1.4; %H - 6
    1.43192; %I - 7
    1.45422; %J - 8
    1.326; %K - 9
    1.18664; %L - 10
    1.064; %M - 11
    0.96366; %N - 12
    0.95021; %O- 13
    0.93021; %P- 14
    0.86889 %Q-15
    ];

hold on
delta = 0.01;

%función 1
x = [Px(1), Px(2)];
y = [Py(1), Py(2)];
x1= Px(1) : delta : Px(2);
y1= spline(x, y, x1);

%función 2
x = [Px(2), Px(3), Px(4)];
y = [Py(2), Py(3), Py(4)];
x2= Px(2) : delta : Px(4);
y2= spline(x, y, x2);

%función 3
x = [Px(4), Px(5), Px(6)];
y = [Py(4), Py(5), Py(6)];
x3= Px(4) : delta : Px(6);
y3= spline(x, y, x3);

%función 4
x = [Px(6), Px(7), Px(8), Px(9), Px(10)];
y = [Py(6), Py(7), Py(8), Py(9), Py(10)];
x4= Px(6) : delta : Px(10);
y4= spline(x, y, x4);

%función 5
x = [Px(10), Px(11), Px(12), Px(13)];
y = [Py(10), Py(11), Py(12), Py(13)];
x5= Px(10) : delta : Px(13);
y5= spline(x, y, x5);

%función 6
x = [Px(13), Px(14), Px(15)];
y = [Py(13), Py(14), Py(15)];
x6= Px(13) : delta : Px(15);
y6= spline(x, y, x6);

%plot(x1, y1, 'r', 'LineWidth',3)
%plot(x2, y2, 'm', 'LineWidth',3)
%plot(x3, y3, 'c', 'LineWidth',3)
%plot(x4, y4, 'k', 'LineWidth',3)
%plot(x5, y5, 'r', 'LineWidth',3)
%plot(x6, y6, 'y', 'LineWidth',3)

X = [x1, x2, x3, x4, x5, x6];
Y = [y1, y2, y3, y4, y5, y6];

%grafica 2d
subplot(1, 2, 1)
plot(X, Y, 'r', 'LineWidth', 3)
xlim([0 7])
ylim([0 2])
%camroll(90)

%grafica 3d
subplot(1, 2, 2)
cylinder(Y)
h = findobj(gca, 'Type', 'surface'); 
if ~isempty(h)
    for k = 1:numel(h)
        set(h(k), ...
            'FaceColor', [1 0 0], ...
            'FaceAlpha', 0.3, ...
            'EdgeColor', 'none');
    end
end


%obtener coeficientes 
P1 = vander(Px(1:2)) \ Py(1:2);
P2 = vander(Px(2:4)) \ Py(2:4);
P3 = vander(Px(4:6)) \ Py(4:6);
P4 = vander(Px(6:10)) \ Py(6:10);
P5 = vander(Px(10:13)) \ Py(10:13);
P6 = vander(Px(13:15)) \ Py(13:15);

%crear funciones con os coeficientes
f1 = @(x) pi*(P1(1)*x+P1(2)).^2; %grado 1 pq solo tiene 2 coef
f2 = @(x) pi*(P2(1)*x.^2 + P2(2)*x + P2(3)).^2; %grado 2 pq tiene 3 coef
f3 = @(x) pi*(P3(1)*x.^2 + P3(2)*x + P3(3)).^2;
f4 = @(x) pi*(P4(1)*x.^4 + P4(2)*x.^3 + P4(3)*x.^2 + P4(4)*x + P4(5)).^2;
f5 = @(x) pi*(P5(1)*x.^3 + P5(2)*x.^2 + P5(3)*x + P5(4)).^2;
f6 = @(x) pi*(P6(1)*x.^2 + P6(2)*x + P6(3)).^2;


v1 = integral(f1, Px(1), Px(2));
v2 = integral(f2, Px(2), Px(4));
v3 = integral(f3, Px(4), Px(6));
v4 = integral(f4, Px(6), Px(10));
v5 = integral(f5, Px(10), Px(13));
v6 = integral(f6, Px(13), Px(15));

vt = v1 + v2 + v3 + v4 + v5 +v6;
%disp("El volumen total es: " + vt + " cm^3")

%densidad del vidrio 
densidad = 2.7; %g/cm^3

%masa
masa = vt * densidad;
%disp("La masa total del florero es " + masa + " gramos")

%masa en kg
masaEnKg = masa/100;
%disp("Masa en kg: "+ masaEnKg)

%precio y costo total
precio = 400; %400 por metro
costo = precio * masaEnKg;

%disp("El costo total del florero es: " + costo)

%funcion de adentro (empezar de nuevo) mas bien copia y pega del codigo
%pero etiquetando

%puntos X funcion de adentro (lo mismo pq no se movieron en x)
P2x = [
    0.6; %F -1
    1.2; %G - 2
    1.8; %H - 3
    2.2; %I - 4
    3.33; %J - 5
    4; %K - 6
    4.5; %L - 7
    4.99; %M - 8
    5.38; %N - 9
    5.56; %O- 10
    5.9; %P- 11
    6.06 %Q-12
    ];


%puntos Y funcion de adentro
P2y = [
    1.06; %F - 1
    1.2; %G - 2
    1.2; %H - 3
    1.23192; %I - 4
    1.25422; %J - 5
    1.126; %K - 6
    0.98664; %L -7
    0.864; %M - 8
    0.76366; %N -9
    0.75021; %O-10
    0.73021; %P- 11
    0.66889 %Q- 12
    ];

hold on
delta = 0.01;

%función 1 se descarto 
%x = [P2x(1), P2x(2), P2x(3)];
%y = [P2y(1), P2y(2), P2y(3)];
%x21= P2x(1) : delta : P2x(3);
%y21= spline(x, y, x21);

%función 1
x = [P2x(1), P2x(2), P2x(3)];
y = [P2y(1), P2y(2), P2y(3)];
x22= P2x(1) : delta : P2x(3);
y22= spline(x, y, x22);

%función 2
x = [P2x(3), P2x(4), P2x(5), P2x(6), P2x(7)];
y = [P2y(3), P2y(4), P2y(5), P2y(6), P2y(7)];
x23= P2x(3) : delta : P2x(7);
y23= spline(x, y, x23);

%función 3
x = [P2x(7), P2x(8), P2x(9), P2x(10)];
y = [P2y(7), P2y(8), P2y(9), P2y(10)];
x24= P2x(7) : delta : P2x(10);
y24= spline(x, y, x24);

%función 4
x = [P2x(10), P2x(11), P2x(12)];
y = [P2y(10), P2y(11), P2y(12)];
x25= P2x(10) : delta : P2x(12);
y25= spline(x, y, x25);



%plot(x21, y21, 'r', 'LineWidth',3)
%plot(x22, y22, 'm', 'LineWidth',3)
%plot(x23, y23, 'c', 'LineWidth',3)
%plot(x24, y24, 'k', 'LineWidth',3)



X2 = [x22, x23, x24, x25];
Y2 = [y22, y23, y24, y25];

%grafica 2d
subplot(1, 2, 1)
hold on
plot(X2, Y2, 'y', 'LineWidth', 3)
xlim([0 7])
ylim([0 2])
camroll(90)

%grafica 3d
subplot(1, 2, 2)
cylinder(Y2)

%obtener coeficientes 
P22 = vander(P2x(1:3)) \ P2y(1:3);
P23 = vander(P2x(3:7)) \ P2y(3:7);
P24 = vander(P2x(7:10)) \ P2y(7:10);
P25 = vander(P2x(10:12)) \ P2y(10:12);


%crear funciones con os coeficientes
%f12 = @(x) pi*(P21(1)*x.^2 + P21(2)*x + P21(3)).^2; 
f22 = @(x) pi*(P22(1)*x.^2 + P22(2)*x + P22(3)).^2; 
f32 = @(x) pi*(P23(1)*x.^4 + P23(2)*x.^3 + P23(3)*x.^2 + P23(4)*x + P23(5)).^2;
f42 = @(x) pi*(P24(1)*x.^3 + P24(2)*x.^2 + P24(3)*x + P24(4)).^2;
f52 = @(x) pi*(P25(1)*x.^2 + P25(2)*x + P25(3)).^2;



%v12 = integral(f12, P2x(1), P2x(3));
v22 = integral(f22, P2x(1), P2x(3));
v32 = integral(f32, P2x(3), P2x(7));
v42 = integral(f42, P2x(7), P2x(10));
v52 = integral(f52, P2x(10), P2x(12));


%vt2 = v12 + v22 + v32 + v42 + v52;
vt2 =  v22 + v32 + v42 + v52;
%disp("El volumen total es: " + vt2 + " cm^3")

%densidad del vidrio 
densidad = 2.7; %g/cm^3

%masa
masa2 = vt2 * densidad;
%disp("La masa total del florero es " + masa2 + " gramos")

%masa en kg
masaEnKg2 = masa2/100;
%disp("Masa en kg: "+ masaEnKg2)

%precio y costo total
precio = 400; %400 por metro
costo2 = precio * masaEnKg2;

%disp("El costo total del florero es: " + costo2)


vResultante = vt - vt2;
masaResultante = masaEnKg - masaEnKg2;
disp("volumen resultante: "+vResultante + " g/cm^3")
disp("masa resultante: " +masaResultante + " kg")
costoR = precio * masaResultante;
disp("costo final: $"+costoR)


