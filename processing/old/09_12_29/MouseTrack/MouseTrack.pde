PVector pos, vel, acc;
float drag = 0.95;

void setup(){
  size(500,500);
  smooth();
  frameRate(50);

  
  pos = new PVector(0,0);
  vel = new PVector(0,0);
  acc = new PVector(0,0);
}

void draw(){
  background(255);
  translate(width*0.5, height*0.5);
  
  mousePush();
  
  noStroke();
  fill(0,50);
  
  vel.add(acc);
  acc.set(0,0,0);
  vel.mult(drag);
  pos.add(vel);
  
  ellipse(pos.x,pos.y,20,20);
}

void mousePush(){
  float speed = 100;
  
  noStroke();
  fill(255,0,0);
  PVector m = new PVector(mouseX-width*0.5, mouseY-height*0.5);
  
  ellipse(m.x, m.y, 5, 5);
  
  if(m != null && pos != null){
    acc.x = cos(atan2(pos.y-m.y, pos.x-m.x))*(1/((pos.x-m.x)*(pos.x-m.x)+(pos.y-m.y)*(pos.y-m.y)))*speed;
    acc.y = sin(atan2(pos.y-m.y, pos.x-m.x))*(1/((pos.x-m.x)*(pos.x-m.x)+(pos.y-m.y)*(pos.y-m.y)))*speed;
  }
}
