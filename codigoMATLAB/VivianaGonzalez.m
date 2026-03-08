%Viviana.m
% Florero en 2d y3d con su volumen y costo
%Viviana González Cervantes
clc

%Puntos X                            
Px = [0;                     %C 1      
   0.130679188872;           %D 2
   0.322123576087;           %P 3
   0.9099385194569;          %E 4
   1.7987144643183;          %F 5
   2.9593830851238;          %G 6
   4.0052114791058;          %H 7
   5;                        %I 8
   7.9677801161125;          %J 9
   9;                        %K 10
   10.0167616037283;         %L 11
   12.0484304690132];        %N 12                     

%Puntos Y
Py = [0.2;                   %C
   1.3928063114762;          %D
   1.9053117325669;          %P
   1.9077485873809;          %E
   2.4813245653181;          %F
   2.902989942628;           %G
   3.0813959627779;          %H
   3;                        %I
   1.8908995496119;          %J
   1.5;                      %K
   1.2835827527995;          %L
   1.7111766125815];         %N

hold on 
delta = 0.01;

% Función #1

x= [Px(1),Px(2),Px(3)];     % Valores X
y= [Py(1),Py(2),Py(3)];     % Valores Y
x1 = Px(1): delta : Px(3);  % Valores Prueba
y1 = spline(x,y,x1);        % Interpolación
%plot(x1,y1, 'r', 'LineWidth',3)

% Función #2

x= [Px(3), Px(4)];     % Valores X
y= [Py(3), Py(4)];     % Valores Y
x2 = Px(3): delta : Px(4);  % Valores Prueba
y2 = spline(x,y,x2);        % Interpolación
%plot(x2,y2, 'g', 'LineWidth',3)

% Función #3

x= [Px(4),Px(5),Px(6), Px(7), Px(8)];     % Valores X
y= [Py(4),Py(5),Py(6), Py(7), Py(8)];     % Valores Y
x3 = Px(4): delta : Px(8);  % Valores Prueba
y3 = spline(x,y,x3);        % Interpolación
%plot(x3,y3, 'c', 'LineWidth',3)

% Función #4

x= [Px(8),Px(9),Px(10),Px(11), Px(12)];     % Valores X
y= [Py(8),Py(9),Py(10),Py(11), Py(12)];     % Valores Y
x4 = Px(8): delta : Px(12);  % Valores Prueba
y4 = spline(x,y,x4);        % Interpolación
%plot(x4,y4, 'y', 'LineWidth',3)

%matrices

X= [x1,x2,x3,x4];
Y= [y1,y2,y3,y4];

%Gráfica 2D
%subplot(1,2,1)
%plot(X,Y,'k', 'LineWidth',3)
%xlim([0 19])
%ylim([0 5])
%camroll(90)

%Gráfica 3D
%subplot(1,2,2)
%cylinder(Y)


%Función 1 volOG
P1 = vander(Px(1:3))\Py(1:3);

f1 = @(x) pi*(P1(1)*x.^2+P1(2)*x+P1(3)).^2;
v1 = integral(f1,Px(1),Px(3));


%Función 2 volOG
P2 = vander(Px(3:4))\Py(3:4);

f2 = @(x) pi*(P2(1)* x + P2(2)).^2;
v2 = integral(f2,Px(3),Px(4));

%Función 3 volOG
P3 = vander(Px(4:8))\Py(4:8);

f3 = @(x) pi*(P3(1)*x.^4+ P3(2)*x.^3+P3(3)*x.^2+P3(4)*x+ P3(5)).^2;
v3 = integral(f3,Px(4),Px(8));

%Función 4 volOG
P4 = vander(Px(8:12))\Py(8:12);

f4 = @(x) pi*(P4(1)*x.^4+ P4(2)*x.^3+P4(3)*x.^2+P4(4)*x+ P4(5)).^2;
v4 = integral(f4,Px(8),Px(12));

%Primer volumen
volumen1 = v1 + v2 + v3 + v4;
%disp (volumen1);











%Masa
d_vidrio = 2.5;
masa = volumen1 * d_vidrio;
%disp (masa);
fprintf('La masa total del florero es:  %.4g\n', masa);

%Costo
preciovidrio = 0.0005;
costo = masa  * preciovidrio;
%disp(costo);
fprintf('El costo total del florero es: $%.4f\n ', costo);







%Puntos a Desfasada(0.2)                           
Pa = [0;                     %C 1      
   0.125961624533;           %O 2
   0.326360589891;           %Q 3
   0.9083240865318;          %R 4
   1.7987144643183;          %S 5
   2.9590999002292;          %T 6
   4.0054906471448;          %U 7
   5;                        %V 8
   7.9676356430947;          %W 9
   9;                        %Z 10
   10.02;                    %A1 11
   12.0494861419543];        %C1 12                     

%Puntos b
Pb = [0.2;                   %C
   1.2454192276128;          %O
   1.7039093214416;          %Q
   1.7062005580703;          %R
   2.4813245653181;          %S
   2.6994658541363;          %T
   2.8805449393682;          %U
   2.8;                      %V
   1.6903931102357;          %W
   1.3;                      %Z
   1.09;                     %A1
   1.5103667892981];         %C1



% Función #1voldes

a= [Pa(1),Pa(2),Pa(3)];     % Valores X
b= [Pb(1),Pb(2),Pb(3)];     % Valores Y
a1 = Pa(1): delta : Pa(3);  % Valores Prueba
b1 = spline(a,b,a1);        % Interpolación
%plot(x1,y1, 'r', 'LineWidth',3)

% Función #2voldes

a= [Pa(3), Pa(4)];     % Valores X
b= [Pb(3), Pb(4)];     % Valores Y
a2 = Pa(3): delta : Pa(4);  % Valores Prueba
b2 = spline(a,b,a2);        % Interpolación
%plot(x2,y2, 'g', 'LineWidth',3)

% Función #3voldes

a= [Pa(4),Pa(5),Pa(6), Pa(7), Pa(8)];     % Valores X
b= [Pb(4),Pb(5),Pb(6), Pb(7), Pb(8)];     % Valores Y
a3 = Pa(4): delta : Pa(8);  % Valores Prueba
b3 = spline(a,b,a3);        % Interpolación
%plot(x3,y3, 'c', 'LineWidth',3)

% Función #4voldes

a= [Pa(8),Pa(9),Pa(10),Pa(11), Pa(12)];     % Valores X
b= [Pb(8),Pb(9),Pb(10),Pb(11), Pb(12)];     % Valores Y
a4 = Pa(8): delta : Pa(12);  % Valores Prueba
b4 = spline(a,b,a4);        % Interpolación
%plot(x4,y4, 'y', 'LineWidth',3)

%matrices

A= [a1,a2,a3,a4];
B= [b1,b2,b3,b4];





%Gráfica 2D
subplot(1,2,1)
plot(X,Y,'k', 'LineWidth',3)
hold on
plot(A,B,'y', 'LineWidth',3)
xlim([0 19])
ylim([0 5])
camroll(90)

%Gráfica 3D
subplot(1,2,2)
hold on
cylinder(Y);
cylinder(B);


%Función 1 voldes
P5 = vander(Pa(1:3))\Pb(1:3);

f5 = @(x) pi*(P5(1)*x.^2+P5(2)*x+P5(3)).^2;
v5 = integral(f5,Pa(1),Pa(3));


%Función 2 voldes
P6 = vander(Pa(3:4))\Pb(3:4);

f6 = @(x) pi*(P6(1)*x+P6(2)).^2;
v6 = integral(f6,Pa(3),Pa(4));

%Función 3 voldes
P7 = vander(Pa(4:8))\Pb(4:8);

f7 = @(x) pi*(P7(1)*x.^4+ P7(2)*x.^3+P7(3)*x.^2+P7(4)*x+ P7(5)).^2;
v7 = integral(f7,Pa(4),Pa(8));

%Función 4 voldes
P8 = vander(Pa(8:12))\Pb(8:12);

f8 = @(x) pi*(P8(1)*x.^4+ P8(2)*x.^3+P8(3)*x.^2+P8(4)*x+ P8(5)).^2;
v8 = integral(f8,Pa(8),Pa(12));

%Volumen Final
voldes= v5 + v6 + v7 + v8;
vfinal = volumen1 - voldes;
%disp (vfinal);
fprintf('El volumen total del florero es: %.4f cm3\n', vfinal);
