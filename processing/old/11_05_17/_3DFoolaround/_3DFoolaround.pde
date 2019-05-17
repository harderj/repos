import processing.opengl.*;

float rX, rY, rZ;

void setup(){
  size(500,500,P3D,OPENGL);
  smooth();
  rX = 0;
  rY = 0;
  rZ = 0;
}

void draw(){
  background(255);
  pushMatrix();
  translate(width*0.5,height*0.5,0);
  rotateX(rX);
  rotateY(rY);
  rotateZ(rZ);
  stroke(0);
  noFill();
  sphereDetail(10);
  sphere(50);
  popMatrix();
  
  float tmp=100;
  rX+=tmp*TWO_PI;
  //rY+=tmp*TWO_PI;
  //rZ+=tmp*TWO_PI;
}
