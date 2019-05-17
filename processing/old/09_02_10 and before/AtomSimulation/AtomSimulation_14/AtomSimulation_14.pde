// Global
import processing.opengl.*;

ArrayList units;
ArrayList flashs;
ArrayList explosions;

PFont font;

float globalVolume = 0.4;
int energyCounter = 0;
int frameCounter = 0;
boolean unitSpreading = false; // false will dramatically improve framerate

// Unit
float speed = 2;
float volume = 4;
int lifeMin = 20;
int lifeMax = 100;
int splits = 3;

// Flash
float flashExspandRate = 5;
float flashLife = 25;
int flashCombineCount = 60;
int flashStrokeVolume = 4;

// Explosion
float explosionExspandRate = 20;
int explosionLife = 25;
int explosionStrokeVolume = 8;

void setup(){
  size(screen.width,screen.height,OPENGL);
  frameRate(25);
  background(0);
  ellipseMode(CENTER);
  smooth();
  units = new ArrayList();
  flashs = new ArrayList();
  explosions = new ArrayList();
  font = loadFont("Arial-Black-48.vlw"); 

  speed *= globalVolume;
  volume *= globalVolume;

  flashExspandRate *= globalVolume;
  flashStrokeVolume *= globalVolume;

  explosionExspandRate *= globalVolume;
  explosionStrokeVolume *= globalVolume;
}

void draw(){
  frameCounter ++;

  fade();
  updateArrays();

  fill(0,255,0);
  textFont(font, 12); 
  text("Nano seconds passed: " + frameCounter, 15, 30);
  text("Neutrons in flight: " + units.size(), 15, 50);
  text("Joule's released: " + (((energyCounter*179)/1.60217653)*0.0000000000000000001), 15, 70);
  text("Joule's released/second: " + (((flashs.size()*179)/1.60217653)*0.0000000000000000001) * 10000000, 15, 90);
}

void fade(){
  noStroke();
  fill(0,0,0,100);
  rect(-1,-1,width+1,height+1);
}

void updateArrays(){
  for(int i=0; i<units.size(); i++){
    ((Unit) units.get(i)).draw();
    if( !((Unit) units.get(i)).active){
      units.remove(i);
    }
  }
  for(int i=0; i<flashs.size(); i++){
    ((Flash) flashs.get(i)).draw();
    if( !((Flash) flashs.get(i)).active){
      flashs.remove(i);
    }
  }
  for(int i=0; i<explosions.size(); i++){
    ((Explosion) explosions.get(i)).draw();
    if( !((Explosion) explosions.get(i)).active){
      explosions.remove(i);
    }
  }
}

void mousePressed(){
  for(int i=0; i<units.size(); i++){
    ((Unit) units.get(i)).active = false;
  }
  float tmpA = atan2(mouseY-pmouseY,mouseX-pmouseX);
  units.add(new Unit(mouseX,mouseY,cos(tmpA),sin(tmpA)));
}
