import processing.opengl.*;

Ball b1, b2;

void setup(){
  size(500,500,P3D,OPENGL);
  smooth();
  lights();
  sphereDetail(10);
  
  b1=new Ball();
  b2=new Ball();
  b1.p=new PVector(random(width),random(width),random(width));
  b2.p=new PVector(random(width),random(width),random(width));
}

float speed = 0.0001;

void draw(){
  background(255);
  
  fill(0);
  stroke(0);
  b1.render();
  b2.render();
  
  /*
  stroke(0);
  fill(255,0,0);
  pushMatrix();
  translate(250, 250, 200);
  scale(5);
  rotateX(millis()*speed);
  sphere(10);
  noFill();
  rotateX(-millis()*speed);
  popMatrix();
  pushMatrix();
  rotateY(millis()*speed);
  box(30);
  fill(0,255,0);
  beginShape();
  vertex(0,10,10);
  vertex(10,10,0);
  vertex(10,0,10);
  vertex(10,10,10);
  endShape(CLOSE);
  popMatrix();
  */
}
