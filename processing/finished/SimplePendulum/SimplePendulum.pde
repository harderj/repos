float angle, speed, distance, acc, vel, drag;

void setup(){
  size(200,200);
  smooth();
  frameRate(20);
  
  angle = 0;
  speed = 0.1;
  distance = 50;
  vel = 0;
  acc = 0;
  drag = 0.95;
}

void draw(){
  fill(0,0,0,50);
  rect(-2,-2,width+4,height+4);
  
  acc = sin(angle + HALF_PI) * speed;
  
  vel += acc;
  
  vel *= drag;
  
  angle += vel;
  acc = 0;
  
  stroke(255);
  strokeWeight(3);
  line(width*0.5, height*0.5, width*0.5 + cos(angle)*distance, height*0.5 + sin(angle)*distance);
}

void mousePressed(){
  angle = atan2(mouseY-height*0.5,mouseX-width*0.5);
  vel=0;
}
