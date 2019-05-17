
Part v1;

void setup(){
  
  size(500,500);
  
  smooth();
  
  v1 = new Part();
  
}


void draw(){
  
  background(255);
  
  float dx = mouseX - v1.p.x;
  float dy = mouseY - v1.p.y;
  
  float ang = atan2(dy, dx);
  
  v1.a.add(0,0.5,0);
  v1.v.mult(0.9);
  
  v1.update();
  v1.draw();
  
}
