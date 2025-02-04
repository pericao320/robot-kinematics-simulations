%Giros

% Parámetros del chasis
x_chasis = [0.4, 0.5, 0.5, 0.4, -0.4, -0.5, -0.5, -0.4, 0.4]; % Girado 90 grados
y_chasis = [0.3, 0.1, -0.1, -0.3, -0.3, -0.1, 0.1, 0.3, 0.3]; % Girado 90 grados

% Dimensiones de las ruedas
rueda_ancho = 0.05; % Ancho de las ruedas (vista superior)
rueda_largo = 0.15; % Largo de las ruedas

% Posiciones de las ruedas en la vista superior (ajustadas para eje X)
wheel_positions = [
    0.25, 0.35;   % Superior derecha
   -0.25, 0.35;   % Superior izquierda
    0.25, -0.35;  % Inferior derecha
   -0.25, -0.35   % Inferior izquierda
];

% Parámetros de simulación cinemática
r = 0.10665; % Radio de la rueda en metros
L = 0.76; % Distancia entre las ruedas en el eje ancho en metros
dt = 0.1; % Intervalo de tiempo en segundos
sim_time = 100; % Aumentar el tiempo de simulación para cerrar el círculo

% Velocidades de las ruedas en rad/s
omega1 = 1; % Velocidad rueda delantera izquierda
omega2 = 2; % Velocidad rueda delantera derecha
omega3 = 1; % Velocidad rueda trasera izquierda
omega4 = 2; % Velocidad rueda trasera derecha

% Posición y orientación inicial
x = 0; % Posición inicial en X
y = 0; % Posición inicial en Y
theta = pi/2; % Orientación inicial (frente hacia el eje X)

% Trayectoria
x_traj = [];
y_traj = [];
theta_traj = [];

% Crear la figura
figure;
hold on;
grid on;
axis equal;
xlabel('X (m)');
ylabel('Y (m)');
title('Trayectoria Circular del Robot');

% Simulación de movimiento
for t = 0:dt:sim_time
    % Cálculo de velocidades
    v = r/4 * (omega1 + omega2 + omega3 + omega4); % Velocidad lineal promedio
    omega = r/(4 * L) * (-omega1 + omega2 -omega3 + omega4); % Velocidad angular
    
    % Actualizar posición y orientación
    x = x + v * dt * cos(theta); % Actualizar posición X
    y = y + v * dt * sin(theta); % Actualizar posición Y
    theta = theta + omega * dt;  % Actualizar orientación
    
    % Guardar trayectoria
    x_traj = [x_traj, x];
    y_traj = [y_traj, y];
    theta_traj = [theta_traj, theta];
    
    % Dibujar el robot en cada paso
    cla;
    R = [cos(theta), -sin(theta); sin(theta), cos(theta)]; % Matriz de rotación
    rotated_chasis = R * [x_chasis; y_chasis];
    plot(rotated_chasis(1, :) + x, rotated_chasis(2, :) + y, 'cyan', 'LineWidth', 2, 'DisplayName', 'Chasis');
    
    % Dibujar ruedas
    for i = 1:size(wheel_positions, 1)
        wheel = wheel_positions(i, :)';
        rotated_wheel = R * wheel + [x; y]; % Rota y desplaza la posición base de la rueda
        
        % Coordenadas locales de la rueda
        local_x = [-rueda_ancho/2, rueda_ancho/2, rueda_ancho/2, -rueda_ancho/2];
        local_y = [-rueda_largo/2, -rueda_largo/2, rueda_largo/2, rueda_largo/2];
        
        % Aplicar rotación inicial de 90 grados
        R_initial = [0, -1; 1, 0]; % Rotación de 90 grados (pi/2 rad)
        rotated_rect = R * R_initial * [local_x; local_y];
        rect_x = rotated_wheel(1) + rotated_rect(1, :);
        rect_y = rotated_wheel(2) + rotated_rect(2, :);
        
        % Dibuja la rueda
        fill(rect_x, rect_y, 'black', 'DisplayName', 'Rueda');
    end
    
    % Dibujar trayectoria
    plot(x_traj, y_traj, 'r', 'LineWidth', 1.5, 'DisplayName', 'Trayectoria');
    pause(0.1);
end

% Gráfica final de la trayectoria
figure;
plot(x_traj, y_traj, 'b', 'LineWidth', 2);
xlabel('X (m)');
ylabel('Y (m)');
title('Trayectoria Circular del Robot');
grid on;
axis equal;
