//float globalScale = 1;
float bindingLimit = 2;
float bindingDistFactor = 1;
float speedBace = 0.3;
float speedSizeFactor = 0.5;

ArrayList drops;

PFont font;

void setup(){
  size(300, 500);
  ellipseMode(CENTER);
  
  font = loadFont("Courier-48.vlw");
  
  //bindingLimit *= globalScale;
  //bindingDistFactor *= globalScale;
  //speedBace *= globalScale;
  //speedSizeFactor *= globalScale;
  
  drops = new ArrayList();
}

void draw(){
  background(0);
  arrays();
  
  drops.add(new Drop(random(width), random(height), random(4)));
  
  fill(0,255,0);
  textFont(font, 10);
  text(frameRate, 1, height*0.96);
  text(drops.size(), 1, height*0.98);
}

void mousePressed(){
  drops.add(new Drop(mouseX, mouseY, random(10)));
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
