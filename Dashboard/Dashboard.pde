//Creado por el equipo de Robótica del C.E.T.i.s. 155 
// url: https://github.com/patos155
// Asesorados por https://github.com/gerghas

import googlemapper.*;
import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
PImage mapa;
GoogleMapper gMapper;

// Implementación del mapa
float mapCenterLat = 21.8857347;
float mapCenterLon = -102.2912996;
int zoomLevel = 10;
String mapType = GoogleMapper.MAPTYPE_HYBRID;
int anchoMapa = 900; 
int altoMapa = 600;

void setup(){
  size(1000,600);// creamos ventana de 700 por 400 pixeles
}