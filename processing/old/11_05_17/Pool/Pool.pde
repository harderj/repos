Ball b1, b2;

PImage table;

float drag = 0.99;

void setup() {

  size(800,438);
  smooth();
  background(255);
  
  table=loadImage("table.png");

  b1 = new Ball(width*0.3,height*0.5,0,0);
  b2 = new Ball(width*0.7,height*0.54,-2,0);
}


void draw() {
  background(table);

  b1.upd();
  b2.upd();

  float dx=b2.p.x-b1.p.x;
  float dy=b2.p.y-b1.p.y;
  float rsum =b1.r+b2.r;
  float d2=sq(dx)+sq(dy);
  if(d2<sq(rsum)) {
    keepDist(b1,b2);
    newVel(b1,b2);
  }

  b1.render();
  b2.render();
}
void keepDist(Ball b1, Ball b2){
  float dx=b2.p.x-b1.p.x;
  float dy=b2.p.y-b1.p.y;
  float rsum =b1.r+b2.r;
  float d2=sq(dx)+sq(dy);
  float d = sqrt(d2);
  float a=atan2(dy,dx);
  float dd = rsum-d;
  b1.p.x += cos(a+PI)*dd*0.5;
  b1.p.y += sin(a+PI)*dd*0.5;
  b2.p.x += cos(a)*dd*0.5;
  b2.p.y += sin(a)*dd*0.5;
}

void newVel(Ball b1, Ball b2) {
  float dx=b2.p.x-b1.p.x;
  float dy=b2.p.y-b1.p.y;
  float d2=sq(dx)+sq(dy);
  
  PVector v_n = new PVector(dx,dy);
  float hyp = sqrt(d2);
  PVector v_un = new PVector(dx/hyp,dy/hyp);
  PVector v_ut = new PVector(-v_un.y,v_un.x);

  float v1n = v_un.dot(b1.v);
  float v1tPrime = v_ut.dot(b1.v);
  float v2n = v_un.dot(b2.v);
  float v2tPrime = v_ut.dot(b2.v);

  float v1nPrime = (v1n*(b1.m-b2.m) + 2*b2.m*v2n)/(b1.m+b2.m);
  float v2nPrime = (v2n*(b2.m-b1.m) + 2*b1.m*v1n)/(b1.m+b2.m);

  PVector v_v1nPrime = new PVector(v_un.x*v1nPrime, v_un.y*v1nPrime);
  PVector v_v1tPrime = new PVector(v_ut.x*v1tPrime, v_ut.y*v1tPrime);
  PVector v_v2nPrime = new PVector(v_un.x*v2nPrime, v_un.y*v2nPrime);
  PVector v_v2tPrime = new PVector(v_ut.x*v2tPrime, v_ut.y*v2tPrime);

  b1.v.x = v_v1nPrime.x + v_v1tPrime.x;
  b1.v.y = v_v1nPrime.y + v_v1tPrime.y;
  b2.v.x = v_v2nPrime.x + v_v2tPrime.x;
  b2.v.y = v_v2nPrime.y + v_v2tPrime.y;
}

class Ball {
  PVector p,v;
  float m=1;
  float r=10;
  
  int tag;

  Ball() {
  }

  Ball(float x, float y, float vx, float vy) {
    p = new PVector(x,y);
    v = new PVector(vx,vy);
  }

  void upd() {
    v.mult(drag);
    p.add(v);
  }

  void render() {
    ellipseMode(CENTER);
    noFill();
    strokeWeight(3);
    stroke(0);
    ellipse(p.x,p.y,r*2,r*2);
  }
}


