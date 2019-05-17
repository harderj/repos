
int startCount = 20;
int columnCount = 10;
int ballRadius = 20;

ArrayList z;
float space;
boolean mousePressing;

void setup() {
  size(500, 500);
  smooth();
  ellipseMode(CENTER);
  z = new ArrayList();

  space = (float(width)/float(columnCount+1));
  mousePressing = false;

  for (int i=0; i < startCount;i++) {
    z.add(new Ball());
  }
}

void draw() {
  background(255);
  strokeWeight(3);
  for (int i=0; i < z.size();i++) {
    float x, y;
    x=x(i);
    y=y(i);
    
    boolean dead = false;
    if (dist2(x, y, mouseX, mouseY)<ballRadius*ballRadius) {
      stroke(0);
      if (mousePressing){
        z.remove(i);
        dead = true;
      }
    }
    else noStroke();
    if(!dead){
    fill( ((Ball) z.get(i)).c );
    ellipse(x, y, ballRadius*2, ballRadius*2);
    }
  }
  mousePressing = false;
}

float dist2(float a, float b, float c, float d) {
  float x=a-c;
  float y=b-d;
  return x*x+y*y;
}

float x(int i) {
  return (float(i%columnCount)+0.5)*space;
}
float y(int i) {
  return (float(i/columnCount)+0.5)*space;
}

class Ball {
  color c;
  Ball() {
    c = color(random(255), random(255), random(255));
  }
}

void mousePressed() {
  mousePressing = true;
}

void keyPressed() {
  z.add(new Ball());
}

