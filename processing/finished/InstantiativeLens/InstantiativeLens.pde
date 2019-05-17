import processing.opengl.*;

float bindingLimit = 2;
float bindingDistFactor = 1;
float speedBace = 0.3;
float speedSizeFactor = 0.5;

ArrayList drops;

PFont font;
PGraphics bg;

void setup(){
  size(500, 300);
  ellipseMode(CENTER);
  
  font = loadFont("Courier-48.vlw");
  
  bg = createGraphics(width, height, P2D);

  bg.beginDraw();
  bg.image(loadImage("Evening.jpg"), 0, 0, bg.width, bg.height);
  bg.endDraw();
  
  drops = new ArrayList();
}

void draw(){
  background(bg);
  
  arrays();
  
  //if(random(1000)>10) drops.add(new Drop(random(100,400), random(100,200), random(1,3)));
  
  fill(0,255,0);
  textFont(font, 10);
  text(frameRate, 1, height*0.96);
  text(drops.size(), 1, height*0.98);
}

void mousePressed(){
  drops.add(new Drop(mouseX, mouseY, random(50)));
}

void arrays(){
  for(int i=0; i<drops.size(); i++) if(((Drop) drops.get(i)).is) ((Drop) drops.get(i)).draw(i);
  else drops.remove(i);
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
