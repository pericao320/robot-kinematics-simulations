%Línea recta

%% Cinemática de robot diferencial línea recta

% Parámetros del robot
R = 0.10815; % Radio de las ruedas (m)
d = 0.38;    % Distancia entre ruedas (m)
L = 0.354;   % Longitud del chasis (m)
W = 0.76;    % Ancho del robot (m)

% Configuración inicial
x = 0;   % Posición inicial en X (m)
y = 0;   % Posición inicial en Y (m)
theta = 0; % Orientación inicial (rad)

% Tiempo de simulación
T = 10; % Duración de la simulación (s)
dt = 0.01; % Paso de tiempo (s)
t = 0:dt:T; % Vector de tiempo

% Velocidades de las ruedas para movimiento en línea recta
v_l = 0.2 * ones(size(t)); % Velocidad rueda izquierda (m/s)
v_r = 0.2 * ones(size(t)); % Velocidad rueda derecha (m/s)

% Inicialización de posiciones
x_trayectoria = zeros(size(t));
y_trayectoria = zeros(size(t));
theta_trayectoria = zeros(size(t));

% Simulación cinemática
for i = 1:length(t)
    % Cálculo de velocidades lineales y angulares
    v = R / 2 * (v_r(i) + v_l(i)); % Velocidad lineal (m/s)
    w = R / d * (v_r(i) - v_l(i)); % Velocidad angular (rad/s)

    % Actualización de posiciones y orientación
    x = x + v * cos(theta) * dt;
    y = y + v * sin(theta) * dt;
    theta = theta + w * dt;

    % Almacenamiento de resultados
    x_trayectoria(i) = x;
    y_trayectoria(i) = y;
    theta_trayectoria(i) = theta;
end

% Visualización
figure;
hold on; grid on;

% Dibujar trayectoria
plot(x_trayectoria, y_trayectoria, 'b-', 'LineWidth', 2);

% Dibujar el robot en cada paso
for i = 1:50:length(t)
    % Coordenadas del chasis del robot
    corners_x = [L/2, -L/2, -L/2, L/2, L/2];
    corners_y = [W/2, W/2, -W/2, -W/2, W/2];
    R_rot = [cos(theta_trayectoria(i)), -sin(theta_trayectoria(i));
             sin(theta_trayectoria(i)),  cos(theta_trayectoria(i))];
    rotated_corners = R_rot * [corners_x; corners_y];

    % Coordenadas globales del chasis
    robot_x = rotated_corners(1, :) + x_trayectoria(i);
    robot_y = rotated_corners(2, :) + y_trayectoria(i);

    % Dibujar el chasis
    plot(robot_x, robot_y, 'r-', 'LineWidth', 1.5);

    % Dibujar las ruedas
    wheel_offset = W/2 + R/2;
    plot([x_trayectoria(i) + L/2, x_trayectoria(i) + L/2], ...
         [y_trayectoria(i) + wheel_offset, y_trayectoria(i) - wheel_offset], 'k-', 'LineWidth', 2);
    plot([x_trayectoria(i) - L/2, x_trayectoria(i) - L/2], ...
         [y_trayectoria(i) + wheel_offset, y_trayectoria(i) - wheel_offset], 'k-', 'LineWidth', 2);
end

hold off;
xlabel('Posición X (m)');
ylabel('Posición Y (m)');
title('Trayectoria del robot diferencial con representación gráfica');
legend('Trayectoria', 'Chasis del robot', 'Ruedas');
axis equal;
