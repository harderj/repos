// Global
import processing.opengl.*;

ArrayList units;
ArrayList flashs;
ArrayList explosions;

PFont font;

float globalVolume = 1;
int energyCounter = 0;
int frameCounter = 0;
boolean unitSpreading = false; // false will dramatically improve framerate

// Unit
float speed = 1;
float volume = 4;
int lifeMin = 20;
int lifeMax = 100;
int splits = 3;

// Flash
float flashExspandRate = 10;
float flashLife = 10;
int flashCombineCount = 40;
int flashStrokeVolume = 4;

// Explosion
float explosionExspandRate = 100;
int explosionLife = 10;
int explosionStrokeVolume = 8;

void setup(){
  size(displayWidth,displayHeight,OPENGL);
  frameRate(25);
  background(0);
  ellipseMode(CENTER);
  smooth();
  units = new ArrayList();
  flashs = new ArrayList();
  explosions = new ArrayList();
  font = loadFont("Arial-Black-48.vlw"); 

  globalUpdate();
}

void globalUpdate(){
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
  if(random(1000)<1){
    units.add(new Unit(random(width), random(height), 0, 0));
  }

  fill(0,255,0);
  textFont(font, 12); 
  text("Nano seconds passed: " + frameCounter, 15, 30);
  text("Neutrons in flight: " + units.size(), 15, 50);
  text("Joule's released: " + (((energyCounter*179)/1.60217653)*0.0000000000000000001), 15, 70);
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

void keyPressed(){
  if(key == 'a'){
    globalVolume *= 1.5;
    globalUpdate();
  }
  if(key == 's'){
    globalVolume *= 0.5;
    globalUpdate();
  }
  if(key == 'p'){
    save("screenShot" + random(0,1000) + ".JPEG");
  }
}

class Explosion{

  boolean active = true;
  float x,y;
  float vol = 5;
  float exspandRate = explosionExspandRate;
  int life = explosionLife;
  int strokeVolume = explosionStrokeVolume;

  Explosion(float x, float y){
    this.x = x;
    this.y = y;
  }

  void draw(){
    if(active){
      age();
      exspand();
      render();
    }
  }

  void age(){
    life --;
    if(life < 1){
      active = false;
    }
  }

  void exspand(){
    vol += exspandRate;
  }

  void render(){
    noFill();
    strokeWeight(strokeVolume);
    stroke(255,255,255,200);
    ellipse(x,y,vol,vol);
  }
}

class Flash{

  boolean active = true;
  float x,y;
  float vol = 5;
  float exspandRate = flashExspandRate;
  int life = 25;
  int combineCount = flashCombineCount;
  int strokeVolume = flashStrokeVolume;

  Flash(float x, float y){
    this.x = x;
    this.y = y;
  }

  void draw(){
    if(active){
      age();
      exspand();
      if(!unitSpreading && active) combine();
      render();
    }
  }

  void age(){
    life --;
    if(life < 1){
      active = false;
    }
  }

  void exspand(){
    vol += exspandRate;
  }

  void combine(){
    float tmpN = 0;
    float tmpX = 0;
    float tmpY = 0;
    float tmpV = 0;
    for(int i=0; i<flashs.size(); i++){
      tmpX = ((Flash) flashs.get(i)).x;
      tmpY = ((Flash) flashs.get(i)).y;
      tmpV = ((Flash) flashs.get(i)).vol;
      if(dist(x,y,tmpX,tmpY) < (vol + tmpV)*0.5){
        tmpN ++;
      }
    }

    if(tmpN > combineCount){
      for(int i=0; i<flashs.size(); i++){
        if(dist(x,y,tmpX,tmpY) < (vol + tmpV)*0.5){
          ((Flash) flashs.get(i)).active = false;
        }
      }
      explosions.add(new Explosion(x,y));
      active = false;
    }
  }

  void render(){
    noFill();
    strokeWeight(strokeVolume);
    stroke(255,200,0,125);
    ellipse(x,y,vol,vol);
  }
}

class Unit{

  boolean active = true;
  float x,y,speX,speY;
  int life;

  Unit(float x, float y, float speX, float speY){
    this.x = x;
    this.y = y;
    this.speX = speX;
    this.speY = speY;
    life = int(random(lifeMin, lifeMax));
  }

  void draw(){
    if(active){
      age();
      if(unitSpreading) avoidFlashs();
      else avoidExplosions();
      move();
      render();
    }
  }

  void age(){
    life --;
    if(life < 1){
      active = false;
      if(x>0 && x<width && y>0 && y<height) explode();
    }
  }

  void explode(){
    flashs.add(new Flash(x,y));
    for(int i=0; i<splits; i++){
      units.add(new Unit(x,y,random(-speed,speed)+speX,random(-speed,speed)+speY));
    }
    energyCounter ++;
  }

  void avoidFlashs(){
    for(int i=0; i<flashs.size(); i++){
      float tmpX = ((Flash) flashs.get(i)).x;
      float tmpY = ((Flash) flashs.get(i)).y;
      float tmpV = ((Flash) flashs.get(i)).vol;
      float tmpA = atan2(y-tmpY,x-tmpX);
      if(dist(x,y,tmpX,tmpY) < tmpV/2){
        speX += cos(tmpA)*(speed*0.02);
        speY += sin(tmpA)*(speed*0.02);
      }
    }
  }

  void avoidExplosions(){
    for(int i=0; i<explosions.size(); i++){
      float tmpX = ((Explosion) explosions.get(i)).x;
      float tmpY = ((Explosion) explosions.get(i)).y;
      float tmpV = ((Explosion) explosions.get(i)).vol;
      float tmpA = atan2(y-tmpY,x-tmpX);
      if(dist(x,y,tmpX,tmpY) < tmpV/2){
        speX += cos(tmpA)*(speed*(tmpV/(explosionLife*explosionExspandRate)));
        speY += sin(tmpA)*(speed*(tmpV/(explosionLife*explosionExspandRate)));
      }
    }
  }

  void move(){
    x += speX;
    y += speY;
  }

  void render(){
    noStroke();
    fill(255);
    ellipse(x,y,volume,volume);
  }
}
