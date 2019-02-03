# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo; y,
2. Sombrear su superficie a partir de los colores de sus vértices.

Referencias:

* [The barycentric conspiracy](https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/)
* [Rasterization stage](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage)

Opcionales:

1. Implementar un [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) para sus aristas; y,
2. Sombrear su superficie mediante su [mapa de profundidad](https://en.wikipedia.org/wiki/Depth_map).

Implemente la función ```triangleRaster()``` del sketch adjunto para tal efecto, requiere la librería [frames](https://github.com/VisualComputing/frames/releases).

## Integrantes

Dos, o máximo tres si van a realizar al menos un opcional.

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|      Sergio Alexander Gil Medina    |      sagilm       |
|      John Alexander Hernandez Carrero      |      joahernandezca       |
|      David Felipe Rodriguez Rodriguez      |      daferodriguez       |

## Discusión

| Comando/Tecla | Accion |
|------------|-------------|
|    "a"     |      Activar o desactivar anti-aliasing       |
|    "g"     |      Activar o desactivar grid       |
|    "+" o "-"    |      Aumentar o disminuir tamaño del grid      |
|    "r"     |      Volver a crear el triangulo      |
|    "d"     |      Activar o desacticar modo "debug"      |
|    "t"     |      Activar o desactivar lineas del triangulo      |
|    "tecla espacio"    |      Gira verticalmente el espacio      |

Para implementar el sombreado del color en el triángulo primero fue necesario usar   la fórmula que encontramos en la documentación para saber la orientación del triángulo, y con esto y la distancia relativa de los vértices se calculaba la tonalidad de cada pixel, en el caso del shading que se muestra hacia el centro se  calculó con base a la distancia relativa entre el punto y el baricentro haciendo una modificación del alpha.

El antialiasing se generó por medio de la técnica de subsampling y se tomó cada pixel en áreas más pequeñas para dar un mejor cálculo en la tonalidad. 

El antialiasingse puede visualizar  'a' en la ejecución.

Con anti Aliasing:

![alt text](https://github.com/Daferodriguez/Raster_ws/blob/master/AntiAliasing.JPG)

Sin anti Aliasing:

![alt text](https://github.com/Daferodriguez/Raster_ws/blob/master/noAntiAliasing.JPG)

## Referencias
- https://fgiesen.wordpress.com/2013/02/08/triangle-rasterization-in-practice/
- http://www.dma.fi.upm.es/personal/mabellanas/tfcs/kirkpatrick/Aplicacion/algoritmos.htm#kirkpatrick
- https://www.youtube.com/watch?v=GvLEAHRmPl0
- https://www.youtube.com/watch?v=C_yh7gw7tbg

## Entrega

* Modo de entrega: [Fork](https://help.github.com/articles/fork-a-repo/) la plantilla en las cuentas de los integrantes.
* Plazo: 30/9/18 a las 24h.
