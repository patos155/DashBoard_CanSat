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
//implementar brujula
PFont b;

int lf = 10;    // parametro para lectura de serial
String myString = null;
float angle;

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


//temperatura
 
PrintWriter output;  //Para crear el archivo de texto donde guardar los datos
 int valor;//Valor de la temperatura
 
//Colores esfera temperatura
float rojo;
float verde;
float azul;
//fin temperatura
 
 
void setup(){
    output = createWriter("temperatura_datos.txt"); //Creamos el archivo de texto, que es guardado en la carpeta del programa
  size(1000,600);// Definimos el tamaño de la ventana. 
  b = loadFont("Arial-BoldMT-48.vlw");//definimos tipo de letra para la brujula
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

//inicia proceso de tempearatura----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
textSize(24);//tamaño del texto
fill(#030303);//color del texto
   text("Temperatura =",250,560);//texto y posicion
   text(valor, 350, 560);//variable de temperatura y posicion
   text("ºC",370,560);//texto y posicion
    
   
      //Escribimos los datos de la temperatura con el tiempo (h/m/s) en el archivo de texto
   output.print(valor + " ºC     ");
   output.print(hour( )+":");
   output.print(minute( )+":");
   output.println(second( ));
   output.println("");
   
    
  //Esfera color visualización temperatura
  float temp = map (valor, 15,32, 0, 255);//Escalamos la temperatura donde maximo sea 32ºC y mínimo 15ºC
  rojo=temp;
  verde=temp*-1 + 255;
  azul=temp*-1 + 255;
  //Dibujamos una esfera para colorear la temperatura
  noStroke();
  fill(rojo,verde,azul);
  ellipseMode(CENTER);
  ellipse(400,552,20,20);
  //termina proceso de temperatura---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//iniciamos proceso de brujula ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//while (myPort.available() > 0) {
  //  myString = myPort.readStringUntil(lf);
    if (myString != null) {
  //print(myString);  // Prints String
    angle=float(myString);  // Converts and prints float
    println(angle);
    }
  //}
  translate(-85,385);

  // draw the compass background
  ellipseMode(CENTER);
  fill(50);
  stroke(10);
  strokeWeight(2);
  ellipse(150,150,130,130);

  // draw the lines and dots
  translate(150,150);  // translate the lines and dots to the middle of the compass
  float CompassX = -angle;
  rotate(radians(CompassX));
  noStroke();
  fill(51, 255, 51);

  int radius = 55;

  for( int degC = 5; degC < 360; degC += 10) //Compass dots
  {
    float angleC = radians(degC);
    float xC = 0 + (cos(angleC)* radius);
    float yC = 0 + (sin(angleC)* radius);
    ellipse(xC,yC, 3, 3);
  }

  for( int degL = 10; degL < 370; degL += 10) //Compass lines
  {
    float angleL = radians(degL);
    float x = 0 + (cos(angleL)* 62);
    float y = 0 + (sin(angleL)* 62);
  
    if( degL==90 || degL==180 || degL==270 || degL==360) {
     stroke(51, 255, 51);
     strokeWeight(4);
    }
    else {
      stroke(234,144,7);
      strokeWeight(2);
    }
    line(0,0, x,y);
  }

  fill(102, 102, 102); 
  noStroke();
  ellipseMode(CENTER);
  ellipse(0,0, 103,103); //draw a filled circle to hide the lines in the middle

  b = loadFont("Arial-BoldMT-48.vlw");//para utilizar este tipo de letra se tiene que importar a la carpeta de tu proyecto el archivo con el mismo nombre que esta en el github
  textAlign(CENTER);

  // Draw the letters
  fill(250);
  textFont(b, 15);
  text("N", 1, -37);
  rotate(radians(90));
  text("E", 0, -37);
  rotate(radians(90));
  text("S", 0, -37);
  rotate(radians(90));
  text("W", 0, -37);
  rotate(radians(90));
  
  textFont(b,40);
  textAlign(CENTER);
  //text((angle), 20, 20);
  println(angle);

  //draw the needle

  rotate(radians(-CompassX)); //make it stationary
  stroke(234,144,7);
  strokeWeight(3);

  triangle(-10, 0, 10, 0, 0, -29);
  fill(234,144,7);
  triangle(-10, 0, 10, 0, 0, 24);
  //termina proceso de brujula +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


}
