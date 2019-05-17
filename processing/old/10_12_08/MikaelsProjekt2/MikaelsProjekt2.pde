
String theText = "ABLETON";
float startHeight = 500;
float DRAG = 5;
float SPEED = 1.0;
boolean showCircles = false;
boolean showLines = false;
float fadeSpeed = 5;
float makeMusicHeight = 0.7;

import processing.opengl.*;

ArrayList ps;

Part v1;
float makeMusicFader = 255;

PFont font;
PImage makeMusic;

void setup(){

  size(1200,500,OPENGL);
  textAlign(CENTER);
  imageMode(CENTER);
  smooth();

  font = loadFont("Verdana-Bold-100.vlw");
  makeMusic = loadImage("makeMusic.png");

  ps = new ArrayList();

  addText(theText);
}

void draw(){
  rectMode(CORNER);
  fill(0,0,0,50);
  rect(-4,-4,width+8, height+8);

  textFont(font, 100);
  for(int i=0; i<ps.size(); i++){
    ((Part) ps.get(i)).update();
    if(showCircles) ((Part) ps.get(i)).drawCircles();
  }
  for(int i=0; i<ps.size(); i++){
    ((Part) ps.get(i)).draw();
  }
  
  float mmX = width*0.5;
  float mmY = height*makeMusicHeight;
  image(makeMusic, mmX, mmY);
  if(makeMusicFader < 255 && makeMusicFader > 0) makeMusicFader -= fadeSpeed;
  noStroke();
  fill(0,0,0,int(makeMusicFader));
  rectMode(CENTER);
  rect(mmX, mmY, makeMusic.width, makeMusic.height);
  
  stroke(125);
  line(width*0.5, 0, width*0.5, height);
  line(0, height*0.5, width, height*0.5);
}


void addText(String txt){

  float tmpN = 1;  
  float tmpW = (float)width/((float)txt.length() - 1 + tmpN*2);
  float tmpH = -startHeight;

  for(int i=0; i<txt.length(); i++){
    PVector tmpV = new PVector(tmpW*(tmpN + i), tmpH);
    ps.add(new Part(tmpV, startHeight+height*0.5, random(PI)+PI, txt.charAt(i)));
  }
}

void keyPressed(){
  if( key == 'r'){

    for(int i=0; i<ps.size(); i++){
      ((Part) ps.get(i)).a = random(PI)+PI;
    }
    
    makeMusicFader = 255;
    
  }
  if(key == 'a'){
    makeMusicFader = 254;
  }
}



