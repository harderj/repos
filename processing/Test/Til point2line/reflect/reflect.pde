import point2line.*;

Vect2 a, b, c;
color WHITE = color(255);
float sc = 100;

void setup(){
  size(300,300);
  smooth();
  
  a = new Vect2(random(TWO_PI));
  b = new Vect2(random(TWO_PI));
  c = new Vect2(reflect(a,b));
}

void draw(){
  background(255);
  translate(width*0.5, height*0.5);
  
  if(mousePressed){
    a.setRotation(atan2(mouseY-width*0.5, mouseX-height*0.5));
    b.rotate(PI*0.01);
    c = new Vect2(reflect(a.angle(),b.angle()));
  }
  
  strokeWeight(3);
  stroke(255,0,0);
  line(0,0,a.x*sc, a.y*sc);
  
  stroke(0,255,0);
  line(0,0,b.x*sc, b.y*sc);
  
  stroke(0,0,255);
  line(0,0,c.x*sc, c.y*sc);
}

Vect2 reflect(Vect2 reflecting, Vect2 reflector){
  Vect2 result = reflecting.copy();
  
  float a = atan2(reflecting.y, reflecting.x);
  float b = atan2(reflector.y, reflector.x);
  //float c = 2*b-a;
  float c = reflect(a,b);
  
  result.setRotation(c);
  
  return result;
}

float reflect(float a, float b){
  return 2*b-a;
}
