
import processing.serial.*;
import controlP5.*;

ControlP5 cp5;
Serial myport;

Dong[][] d;
int nx = 10;
int ny = 10;


DigitalClock digitalClock;

PImage img;

int myColor = color(0,0,0);

String value ;

float capteurC ;
float capteurH;
float capteurT ;
float compteurV ;
float compteurTr_min ;


void setup() {

size(700,400);

//myport= new Serial (this,Serial.list()[0],9600);
//println(Serial.list());
//myport.bufferUntil('\n');

    d = new Dong[nx][ny];
  for (int x = 0;x<nx;x++) {
    for (int y = 0;y<ny;y++) {
      d[x][y] = new Dong();
    }
  } 
  
  digitalClock = new DigitalClock(40, width/2, height/2+15);
  
img = loadImage("bg2.jpg");
  
  cp5 = new ControlP5(this);
  
  
  
 cp5.addKnob("Vitesse")
               .setRange(0,255)
               .setValue(50)
               .setPosition(50,250)
              // .setNumberOfTickMarks(50)
               .setTickMarkLength(4)
               .snapToTickMarks(true)
               .setColorForeground(color(255))
               .setColorBackground(color(100, 150, 250))
               .setColorActive(color(255,255,0))
               .setRadius(50)
               .setDragDirection(Knob.VERTICAL)
               ;
                     
cp5.addKnob("Tours/Min")
               .setRange(0,255)
               .setValue(220)
               .setPosition(550,250)
               .setRadius(50)
               //.setNumberOfTickMarks(50)
               .setTickMarkLength(4)
               .snapToTickMarks(true)
               .setColorForeground(color(255))
               .setColorBackground(color(100, 150, 250))
               .setColorActive(color(255,255,0))
               .setDragDirection(Knob.HORIZONTAL)
               ;
  
  
  cp5.addSlider("Carburant")
     .setPosition(330,250)
     .setSize(20,100)
     .setRange(0,255)
     ;
     
  cp5.addSlider("huile")
     .setPosition(410,250)
     .setSize(20,100)
     .setRange(0,255)
     ;
     
  cp5.addSlider("Temperature")
     .setPosition(250,250)
     .setSize(20,100)
     .setRange(0,255)
     ;   
     

}
void draw() { 
background(img);
imageMode(CENTER);

  pushMatrix();
  translate(width/2 , height/2);
  rotate(frameCount*0.001);
  for (int x = 0;x<nx;x++) {
    for (int y = 0;y<ny;y++) {
      d[x][y].display();
    }
  }
  popMatrix();

  digitalClock.getTime();
  digitalClock.display();

cp5.getController("Carburant").setValue(capteurC);
cp5.getController("huile").setValue(capteurH);
cp5.getController("Vitesse").setValue(compteurV);
cp5.getController("Tours/Min").setValue(compteurTr_min);
cp5.getController("Temperature").setValue(capteurT);

}
void serialEvent (Serial myport){
println("ok");  
String value = myport.readStringUntil ('\n');

if ( value != null){
    value = trim(value) ;

    String[] input =split(value,' ');
    
if (input.length >1 ){
      capteurC = float(input[0]);
      println(capteurC);
     capteurT = float (input[1]);
      println(capteurT);
      compteurV = float (input[2]);
      println(compteurV);
      compteurTr_min = float (input[3]);
      println(compteurTr_min);
      capteurH = float (input[4]);
      println(capteurH);
    }
    //println();
}
}


class DigitalClock extends Clock {
  int fontSize;
  float x, y;
  
  DigitalClock(int _fontSize, float _x, float _y) {
    fontSize = _fontSize;
    x =340;
    y =75;
  }
  
     void getTime() {
    super.getTime();
  }
  
  void display() {
    textSize(fontSize);
    textAlign(CENTER);
    text (h + ":" + nf(m, 2) + ":" + nf(s, 2), x, y);
  } 
}

class Clock {
  int h, m, s;
  Clock() {
  }
  
  void getTime() {
    h = hour();
    m = minute();
    s = second();
  }
}            


class Dong {
  float x, y;
  float s0, s1;

  Dong() {
    float f= random(-PI, PI);
    x = cos(f)*random(100, 500);
    y = sin(f)*random(100, 500);
    s0 = random(2, 5);
  }

  void display() {
    s1 += (s0-s1)*0.01;
    ellipse(x, y, s1, s1);
  }

  void update() {
    s1 = 50;
  }
}

  
