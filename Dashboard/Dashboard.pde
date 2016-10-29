//Creado por el equipo de Robótica del C.E.T.i.s. 155 
// url: https://github.com/patos155
// Asesorados por https://github.com/gerghas

import googlemapper.*;
import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
PImage mapa;
GoogleMapper gMapper;
//imagen 
PImage satelite;// define el tipo de la variable y el nombre
/*Para utilizar una imagen es importante subir el archivo a processing
Seleccionar "sketch"
Despues en "añadir archivo"
Seleccionar la imagen a utilizar
*/
// Implementación del mapa
float mapCenterLat = 21.8857347;
float mapCenterLon = -102.2912996;
int zoomLevel = 10;
String mapType = GoogleMapper.MAPTYPE_HYBRID;
int anchoMapa = 900; 
int altoMapa = 600;

void setup(){
  size(1000,600);// creamos ventana de 700 por 400 
    satelite=loadImage("satelite_.png");//se Carga la imagen ("nombre de la imagen y su formato")
}

void draw(){
image(satelite,longitud,latitud,50,50);//se define las caracteristicas de la imagen(nombre de la imagen,cordenadaX,cordenadaY,ancho,largo)
}
