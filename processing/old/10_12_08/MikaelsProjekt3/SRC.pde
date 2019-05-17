
import processing.opengl.*;

ArrayList ps;

float minVel = 0.0001;
boolean showLines = false;
int showGrid = 0;
float makeMusicFader = 255;
float startHeight = 500;
int gridModes = 2;

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
  fill(0,0,0,(int)screenFade);
  rect(-4,-4,width+8, height+8);
  
  makeMusicFunc();

  textFont(font, 100);
  for(int i=0; i<ps.size(); i++){
    ((Part) ps.get(i)).update();
    ((Part) ps.get(i)).drawCircles();
  }
  for(int i=0; i<ps.size(); i++){
    ((Part) ps.get(i)).draw();
  }

  if(showGrid == 1){
    stroke(125);
    line(width*0.5, 0, width*0.5, height);
    line(0, height*0.5, width, height*0.5);
  }
}

void makeMusicFunc(){
  float tmpAng = ((Part) ps.get(0)).a;
  float tmpVel = ((Part) ps.get(0)).av;
  if(tmpAng < PI*0.52 && tmpAng > PI*0.48 && abs(tmpVel) < minVel && makeMusicFader > 254) makeMusicFader = 254;
  
  float mmX = width*0.5;
  float mmY = height*makeMusicHeight;
  image(makeMusic, mmX, mmY);
  if(makeMusicFader < 255 && makeMusicFader > 0) makeMusicFader -= makeMusicFadeSpeed;
  noStroke();
  fill(0,0,0,int(makeMusicFader));
  rectMode(CENTER);
  rect(mmX, mmY, makeMusic.width, makeMusic.height);
}


void addText(String txt){

  float tmpN = charDensity;  
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
  if(key == 'g') showGrid = (showGrid+1)%gridModes;
  if(key == 'l') showLines = !showLines;
}

