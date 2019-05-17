float globalScale = 1;
float globalTranslateX = 0;
float globalTranslateY = 0;
float globalRotate = 0;

float aScale = 1;
float aTranslateX = 0;
float aTranslateY = 0;
float aRotate = 0;

float fixX = 0;
float fixY = 0;

void setup(){
  fill(255,255,255,100);
  noStroke();
}

void draw(){
  background(0);
  translate(globalTranslateX,globalTranslateY);
  rotate(globalRotate);
  scale(globalScale);
  rect(0,0,20,20);
  pushMatrix();
  translate(aTranslateX,aTranslateY);
  rotate(aRotate);
  scale(aScale);
  rect(0,0,20,20);
  popMatrix();

  if(mousePressed){
    if(mouseButton == LEFT){
      float tmpR = aRotate;
      float tmpS = aScale;
      if(key == 'r') aRotate = tmpR-atan2(fixX-mouseY,fixY-mouseX);
      if(key == 's') aScale = fixY-mouseY;
      if(key == 't') aTranslateX = mouseX; aTranslateY = mouseY;
    }
    if(mouseButton == RIGHT){
      float tmpR = globalRotate;
      float tmpS = globalScale;
      if(key == 'r') globalRotate = tmpR-atan2(fixX-mouseY,fixY-mouseX);
      if(key == 's') globalScale = tmpS-dist(fixX,fixY,mouseX,mouseY);
      if(key == 't') globalTranslateX = mouseX; globalTranslateY = mouseY;
    }
  }
} 

void mousePressed(){
  fixX = mouseX;
  fixY = mouseY;
}
