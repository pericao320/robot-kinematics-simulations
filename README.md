# Simulaciones de Cinemática de Robot Móvil en MATLAB

Este repositorio contiene implementaciones en MATLAB para simular la cinemática de un robot móvil diferencial y omnidireccional. Se incluyen distintos tipos de trayectorias como desplazamiento en línea recta, giros circulares y rotación sobre su propio eje.

## Contenido del repositorio

### Archivos principales:

1. **Giros.m**  
   - Simula la trayectoria circular del robot al ajustar las velocidades de las ruedas.  
   - Visualiza la trayectoria generada en el entorno de simulación de MATLAB.

2. **Línea recta.m**  
   - Simula el movimiento en línea recta de un robot diferencial.  
   - Representa la trayectoria en un diagrama con cambios en la orientación.

3. **Rotación en el mismo eje.m**  
   - Simula la rotación sobre su propio eje de un robot móvil.  
   - Ajusta la velocidad de las ruedas para generar el giro sin desplazamiento lineal.

## Requisitos

Para ejecutar estos scripts, es necesario contar con:
- MATLAB (versión reciente recomendada)
- Conocimientos básicos de cinemática de robots

## Uso

1. Descarga o clona el repositorio.
2. Abre MATLAB y navega hasta la carpeta donde se encuentran los archivos.
3. Ejecuta el script deseado escribiendo en la consola de MATLAB:
   ```matlab
   run('Giros.m')
   ```
   o
   ```matlab
   run('Línea recta.m')
   ```
   o
   ```matlab
   run('Rotación en el mismo eje.m')
   ```
4. Observa las simulaciones gráficas generadas en MATLAB.

## Contacto
Si tienes alguna duda o sugerencia, no dudes en crear un *issue* o contribuir con mejoras en el código.

