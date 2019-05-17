Vect2 pos, vel, acc, gravity;
float distance;

void setup(){
  size(400,400);
  
  smooth();
  
  distance = 40;
  gravity = new Vect2(0.0, 0.5);
  
  pos = new Vect2(width*0.5, height*0.5);
  vel = new Vect2();
  acc = new Vect2();
}

void draw(){
  background(0);
  float angle = atan2(pos.y-mouseY, pos.x-mouseX);
  
  acc.add(gravity);
  
  pos.set(mouseX + cos(angle)*distance, mouseY + sin(angle)*distance);
  acc.mult(-cos(angle), -sin(angle));
  
  vel.add(acc);
  pos.add(vel);
  acc.set();
  
  noFill();
  stroke(255);
  line(pos.x, pos.y, mouseX, mouseY);
  ellipse(pos.x, pos.y, 10, 10);
}
