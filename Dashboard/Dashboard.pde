//Creado por el equipo de Robótica del C.E.T.i.s. 155 
// url: https://github.com/patos155
// Asesorados por https://github.com/gerghas

//Librerías
import googlemapper.*;
import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
PImage mapa;
GoogleMapper gMapper;

//imagen 
PImage satelite;// define el tipo de la variable y el nombre
/*Para utilizar una imagen es importante subir el archivo a processing
 - Seleccionar "sketch"
 - Despues en "añadir archivo"
 - Seleccionar la imagen a utilizar
*/

// Implementación del mapa
float mapCenterLat = 21.8857347;
float mapCenterLon = -102.2912996;
int zoomLevel = 10;
String mapType = GoogleMapper.MAPTYPE_HYBRID;
int anchoMapa = 900; 
int altoMapa = 600;

float latitud;
float longitud;
float minLatitudCanSatY;
float maxLatitudCanSatY;
float minLongitudCanSatX;
float maxLongitudCanSatX;
float CanSatLatitud;
float CanSatLongitud;
FloatList coordenadasX;
FloatList coordenadasY;

void setup(){
  size(1000,600);// Definimos el tamaño de la ventana. 
  satelite=loadImage("satelite_.png");//se Carga la imagen ("nombre de la imagen y su formato")
  gMapper = new GoogleMapper(mapCenterLat, mapCenterLon, zoomLevel, mapType, anchoMapa, altoMapa);
  mapa = gMapper.getMap();
  minLatitudCanSatY = 22.2683885;
  maxLatitudCanSatY = 21.4986971;
  minLongitudCanSatX = -102.9348029;
  maxLongitudCanSatX = -101.6658820;
  
  CanSatLatitud = mapCenterLat;
  CanSatLongitud = mapCenterLon;
  
  coordenadasX = new FloatList();
  coordenadasY = new FloatList();
  
   
}

void draw(){
  background(100,100,100);
  image(mapa,0,0);
image(satelite,longitud,latitud,50,50);//se define las caracteristicas de la imagen(nombre de la imagen,cordenadaX,cordenadaY,ancho,largo)
CanSatLatitud = CanSatLatitud + random(-0.001, 0.002);
CanSatLongitud = CanSatLongitud + random(-0.002, 0.001);
                           //    22.6         21.49
latitud = map(CanSatLatitud, minLatitudCanSatY, maxLatitudCanSatY, 0, altoMapa);
longitud = map(CanSatLongitud, minLongitudCanSatX, maxLongitudCanSatX, 0, anchoMapa);

coordenadasX.append(longitud);
coordenadasY.append(latitud);

}