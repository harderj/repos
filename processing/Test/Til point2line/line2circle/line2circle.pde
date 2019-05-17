import point2line.*;

Vect2 a, b, c, d;
float r = 50;
float lA, lB;

void setup(){
  size(300,300);
  smooth();
  ellipseMode(CENTER);

  a = new Vect2(random(width)-width*0.5, random(height)-height*0.5);
  b = new Vect2(random(width)-width*0.5, random(height)-height*0.5);
  c = new Vect2();
  d = new Vect2();

  lA = lineTilt(a,b);
  lB = lineOffset(a,b);
}

void draw(){
  background(255);
  translate(width*0.5, height*0.5);

  if(keyPressed){
    if(key == '1') a.set(mouseX-width*0.5, mouseY-height*0.5);
    if(key == '2') b.set(mouseX-width*0.5, mouseY-height*0.5);
    float aAb = atan2(a.y-b.y, a.x-b.x);
    lA = lineTilt(aAb);
    lB = lineOffset(a,b);
    d.set(line2Circle(aAb));
  }

  strokeWeight(3);
  stroke(200);
  line((width*-0.5), lA*(width*-0.5) + lB, (width*0.5), lA*(width*0.5) + lB);
  ellipse();

  noFill();
  stroke(255,0,0);
  ellipse(c.x, c.y, r*2, r*2);

  stroke(0,255,0);
  line(a.x, a.y, b.x, b.y);
  stroke(0);
  point(b.x, b.y);
  strokeWeight(1);
  ellipse(a.x, a.y,5,5);
}

Vect2 line2circle(Vect2 s, float angle, Vect2 circle, float r){
  Vect2 result = circle.copy();
  float startAcircle = atan2(s.y-circle.y, s.x-circle.x);
  
  float a = lineTilt(angle);
  float b = lineOffset(s, a);
  
  if(abs(startAcircle) == startAcircle){
    if(startAcircle<PI*0.5){
      result.x = -(-s.x-a*s.y-a*b+sqrt(2*s.x*a*s.y+2*s.x*a*b-2*b*s.y-s.y*s.y+r*r-b*b-a*a*s.x*s.x+a*a*r*r))/(1+a*a);
      result.y = result.x*a+b;
    }
    else {
      
    }
  } 
  else {
    if(abs(startAcircle)<PI*0.5){
      
    }
    else {
      
    }
  }
  
  return result;
}

float lineTilt(Vect2 v1, Vect2 v2){
  return (v1.y-v2.y)/(v1.x-v2.x);
}

float lineTilt(float angle){
  return tan(angle);
}

float lineOffset(Vect2 v1, Vect2 v2){
  return v1.y-(v1.x*((v1.y-v2.y)/(v1.x-v2.x)));
}

float lineOffset(Vect2 v, float a){
  return v.y-(v.x*a);
}

