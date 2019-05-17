float bX = 0;
float bY = 6;

float function(float x, float y){
  float a = 2;
  float c = 0;
  float d = 2;

  y = pow(x-bX, d) * c + (x-bX) * a + bY;
  //y = cos(x)*a + b;
  y += span*0.5;
  
  if(inbound(y, 0, span/yScale, true)){
    inboundary = true;
  } else {
    inboundary = false;
  }
  
  return inbound(y, 0, span/yScale);
}

boolean inboundary = true;
int count = 1000;
int current = 0;
float yScale = 1;
float precision = 0.01;
float span = count*precision;
float scale;
float scaleIndicatorLength = 20;
float lineLimit = span*0.3;
Vector2[] posision = new Vector2[count];

PFont font;

void setup(){
  size(400,400);
  smooth();
  background(255);

  scale = (width)/span;

  font = loadFont("Courier-48.vlw");

  for(int i=0; i<count; i++){
    posision[i] = new Vector2();
  }
  
  drawGrid();
}

void draw(){
  drawGraph();
  drawIndicatorLine();
}

void drawIndicatorLine(){
  stroke(125);
  strokeWeight(5);
  line(10,10,10+scaleIndicatorLength,10);
  float tmpLength = scaleIndicatorLength/scale;
  textFont(font, 12);
  text(tmpLength, 5, 30);
}

void drawGrid(){
  stroke(125);
  float tmpX = bX*scale;
  float tmpY = (span*0.5)*scale*yScale;
  println(tmpY);
  line(0,tmpY,width,tmpY);
  line(tmpX,0,tmpX,height);
}

void drawGraph(){
  pushMatrix();

  translate(0,height);

  rotate((TWO_PI/4)*3);
  if(current < count-1) current ++;
  
  posision[current].x = precision*current;
  posision[current].y = function(posision[current].x, posision[current].y)*yScale;
  
  strokeWeight(3);
  if(inboundary) stroke(0);
  else stroke(150);

  if(dist(posision[current].x, posision[current].y, posision[current-1].x, posision[current-1].y)<lineLimit){
    posision[current].mult(scale);
    posision[current-1].mult(scale);
    line(posision[current-1].y, posision[current-1].x, posision[current].y,  posision[current].x);
    posision[current].div(scale);
    posision[current-1].div(scale);
  }
  popMatrix();
}

float inbound(float value, float minimum, float maximum){
  
  while(value>maximum){
    value -= maximum - minimum;
  }

  while(value<minimum){
    value += maximum - minimum;
  }

  return value;
}

boolean inbound(float value, float minimum, float maximum, boolean flag){
  boolean tmp = flag;
  
  if(value>maximum || value<minimum){
    if(tmp) tmp = false;
    else tmp = true;
  } else {
    if(!tmp) tmp = true;
    else tmp = false;
  }

  return tmp;
}

