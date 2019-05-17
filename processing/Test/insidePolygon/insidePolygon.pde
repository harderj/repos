import point2line.*;

int num = 5;
Vect2[] p;
Vect2 m;

void setup(){
  size(500,500);
  smooth();
  
  m = new Vect2();
  p = new Vect2[num];
  
  for(int i=0; i<num; i++){
    p[i] = new Vect2(random(TWO_PI));
    p[i].setMagnitude(random(min(width,height)*0.5));
    p[i].add(width*0.5, height*0.5);
  }
}

void draw(){
  background(255);
  m.set(mouseX, mouseY);
  
  if(insidePolygon(m, p)) fill(255,100,100);
  else fill(200);
  stroke(0);
  strokeWeight(3);
  beginShape();
  for(int i=0; i<num; i++){
    vertex(p[i].x, p[i].y);
  }
  endShape(CLOSE);
}
