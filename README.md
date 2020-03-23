# Face tools

An application that uses face detection for drawing and trying heads using [Processing](https://processing.org).
> **Adrián Lorenzo Melián** - *Creando Interfaces de Usuario*, [**ULPGC**](https://www.ulpgc.es).
> adrian.lorenzo101@alu.ulpgc.es

<div align="center">
 <img src=images/demo1.gif alt="Creator demo"></img>
 <p>Figura 1 - Demostración de la ejecución del modo de la aplicación "Face Drawer"</p>
</div>

<div align="center">
 <img src=images/demo2.gif alt="Creator demo"></img>
 <p>Figura 2 - Demostración de la ejecución del modo de la aplicación "Head Wardrobe"</p>
</div>

***

## Índice
* [Introducción](#introduction)
* [Requisitos](#requirements)
* [Instrucciones de uso](#instructions) 
* [Implementación](#implementation)
    * [Lienzo de dibujo](#canvas)
    * [Masks](#masks)
* [Herramientas y recursos utilizados](#tools-and-resources)
* [Referencias](#references)

## Introducción <a id="introduction"></a>
El objetivo de esta práctica es **hacer uso de una combinación de salida gráfica en respuesta a una entrada de vídeo.** Para ello, se ha desarrollado una pequeña herramienta que hace uso de los frames obtenidos de la cámara para realizar dos tareas diferentes a partir de dos modos.

El primer modo, denominado **Face Drawer**,**permite realizar dibujos en un lienzo haciendo uso de la parte central de la cara como puntero**. El segundo, denominado **Head Wardrobe**, **coloca a las caras que aparezcan en el vídeo caretas/cabezas en tiempo real**, pudiendo elegir entre tres opciones diferentes.

## Requisitos <a id="requirements"></a>
Para hacer uso de esta aplicación, es necesario **tener instaladas la librería [Video](https://processing.org/reference/libraries/video/index.html) de Processing**, y **la librería compilada CVImage de [Bryan Chung](http://www.magicandlove.com/blog/2018/11/22/opencv-4-0-0-java-built-and-cvimage-library/)** (que incluye OpenCV 4.0.0).  

## Instrucciones de uso<a id="instructions"></a>
En el modo **Face Drawer**, mantén pulsado `Space`/`Espacio` para **dibujar en el lienzo**. Si deseas **borrar todo el trabajo realizado**, pulsa la tecla `Backspace`/`Retroceso`.

El el modo **Head Wardrobe**, pulsa `Space`/`Espacio` para **cambiar de cabeza/careta**. Si deseas **visualizar las caras eliminando las cabezas/caretas**, mantén pulsado la tecla `Backspace`/`Retroceso`.

El programa se inicia en el modo **Face Drawer**. Para cambiar de modo, solo debes pulsar la tecla `Enter`.

## Implementación <a id="implementation"></a>

Ambos modos hacen uso del **marco de detección de Viola and Jones[1] para la detección de caras**. A partir de conocer la posición y tamaño de la cara, el resto de tareas funcionan de manera diferente.

### Lienzo de dibujo <a id="canvas"></a>
Para dibujar usando la cara, el algoritmo utilizado es muy sencillo. El primer paso es detectar la cara. A partir de obtener la cara, es necesario **obtener el punto medio del rectángulo que describe la cara. Este punto define la posición del puntero en el lienzo.**

Cada vez que el usuario dibuja un punto, está **almacenando en una lista el punto medio de su cara,** que luego se dibujará en el canvas. Esta lista tiene tamaño limitado para evitar sobrecarga, eliminándose primero el punto más antiguo.

```java
if (facesArr.length > 0) {  
  if (isSpacePressed){
    if (points.size() == maxPoints) {
      points.remove(maxPoints-1);
    }
    points.add(0,
      new PVector(
        facesArr[0].x + facesArr[0].width/2,
        facesArr[0].y + facesArr[0].height/2
      )
    );
  } else {
    circle(
      facesArr[0].x + facesArr[0].width/2, 
      facesArr[0].y + facesArr[0].height/2, 
      circleSize
    );
  }
}
```

### Máscaras <a id="masks"></a>
Teniendo la posición y tamaño del rectángulo donde se encuentra la cara en la imagen, es muy sencillo añadir una máscara a una cara en una imagen. Para ello, solo hay que **superponer la máscara con un tamaño adecuado en la posición de la cara** (en nuestro caso, un poco mayor al tamaño de la cara, para un mejor resultado visual).

## Herramientas y recursos utilizados <a id="tools-and-resources"></a>

- [*Happy Smiley Face*. Wikipedia Commons](https://es.m.wikipedia.org/wiki/Archivo:Happy_smiley_face.png) - Imagen bajo licencia Creative Commons 0 (Dominio público).
- [*Plum face with green eyes.* Wikipedia Commons](https://commons.wikimedia.org/wiki/File:Pink_or_Plum_Robot_Face_With_Green_Eyes.png) - Imagen bajo licencia Creative Commons 0 (Dominio público).
- [*Bearded man*. Free SVG](https://freesvg.org/vector-illustration-of-bearded-man-pixel-icon) - Imagen de dominio público.
- [Giphy](https://giphy.com) - Herramienta usada para la creación de gifs a partir de los frames de la aplicación.

## Referencias <a id="references"></a>
- ***Guión de Prácticas 2019/20**, Creando Interfaces de Usuario*. Modesto F. Castrillón Santana, J Daniel Hernández Sosa.


