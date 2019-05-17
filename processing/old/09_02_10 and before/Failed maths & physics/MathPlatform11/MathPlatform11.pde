PFont font;

float globalScale, patternAlpha;
int patternCount, textSizeBace;

Vect offset;

void setup(){
  size(500, 500);
  smooth();
  font = loadFont("CourierNewPSMT-48.vlw");
  
  globalScale = 10;
  patternCount = 10;
  patternAlpha = 100;
  textSizeBace = 3+((width +height)*0.5)*0.01;
  
  offset = new Vect(0,0);
}

void draw(){
  
}

void mousePressed(){
  
  update();
}

void keyPressed(){
  
  update();
}

void update(){
  background(255);
  renderMap();
  
  println("Update Complete: " + frameRate);
}

void renderMap(){
  // main axa
  noFill();
  stroke(0);
  line(offset.n[0], 0, offset.n[0], height);
  line(0, offset.n[1], width, offset.n[1]);
  
  // pattern
  float spaceX = width/patternCount;
  float spaceY = height/patternCount;
  noFill();
  stroke(0, 0, 0, patternAlpha);
  for(int i=0; i<patternCount; i++) line(i*spaceX, 0, i*spaceX, height);
  for(int i=0; i<patternCount; i++) line(0, i*spaceY, width, i*spaceY);
  
  // text
  fill(0, 0, 0, textAlpha);
  noStroke();
  textFont(font, textSizeBace);
  for(int i=0; i<patternCount; i++){
    text(i*, i*spaceX, height);
  }
}
