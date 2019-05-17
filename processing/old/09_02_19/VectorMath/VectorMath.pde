int count = 1000;
int current = 0;
float precision = 0.1;
float span = count*precision;
float scale;
float scaleIndicatorLength = 20;
//Vector2 offset = new Vector2(0.0,0.0);
float 
Vector2[] posision = new Vector2[count];

PFont font;

void setup(){
  size(400,400);
  smooth();
  
  scale = (width)/span;
  
  font = loadFont("Courier-48.vlw");
   
  for(int i=0; i<count; i++){
    posision[i] = new Vector2();
  }
}

void draw(){
  drawGraph();
  drawIndicatorLine();
  drawMouseText();
}

void drawMouseText(){
  fill(0);
}

void drawIndicatorLine(){
  line(10,10,10+scaleIndicatorLength,10);
  float tmpLength = scaleIndicatorLength/scale;
  textFont(font, 12);
  text(tmpLength, 5, 30);
}

void drawGraph(){
  pushMatrix();
  
  translate(0,height);
  
  rotate((TWO_PI/4)*3);
  if(current < count-1) current ++;
  
  posision[current].x = precision*current-offset.x;
  
  posision[current].y = tan(posision[current].x)+10;
  
  stroke(0);
  strokeWeight(2);
  posision[current].mult(scale);
  posision[current-1].mult(scale);
  line(posision[current-1].y, posision[current-1].x, posision[current].y,  posision[current].x);
  posision[current].div(scale);
  posision[current-1].div(scale);
  
  popMatrix();
}
