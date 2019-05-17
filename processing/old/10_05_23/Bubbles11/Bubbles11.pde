ArrayList parts;
PVector mouse;

float drag = 0.99;

void setup(){
  size(500,500);
  smooth();

  parts = new ArrayList();
  mouse = new PVector();
}

void draw(){
  baseVars();

  update();
}

void baseVars(){
  background(255);
  mouse.x = mouseX;
  mouse.y = mouseY;
  //println(parts.size());
}

void update(){
  for(int i=0; i<parts.size(); i++){
    if(((Part) parts.get(i)).is) ((Part) parts.get(i)).update();
    else parts.remove(i);
  }
}

void mousePressed(){
  parts.add(new Part(mouse));
}
