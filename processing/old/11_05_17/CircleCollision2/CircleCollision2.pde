int num = 500;
float ballR = 50;
float airDrag =1;
float ballDrag =1;
float frameDrag =1;
PVector g = new PVector(0,0);
float mouseR=20;

ArrayList bs = new ArrayList();
int s;
float w,h;

void setup() {
  size(700,700);
  smooth();
  background(255);
  w=width;
  h=height;
  for(int i=0;i<num;i++) bs.add(new Ball(random(w*0.3),random(h*0.3),0,0,5,1));
}


void draw() {
  background(255);
  s = bs.size();

  for(int i=0;i<s;i++) ((Ball) bs.get(i)).upd();
  collideBalls();
  for(int i=0;i<s;i++) ((Ball) bs.get(i)).render();
  
  keyExtras();
}

void collideBalls() {
  for(int i=0;i<s;i++) {
    Ball b1 = ((Ball) bs.get(i));
    for(int j=i+1;j<s;j++) {
      Ball b2 = ((Ball) bs.get(j));
      if(colliding(b1,b2)) {
        keepOutside(b1,b2);
        circleCollision(b1,b2);
        b1.v.mult(ballDrag);
        b2.v.mult(ballDrag);
      }
    }
  }
}

class Ball {
  PVector p,v;
  float m=1;
  float r;

  Ball(float x, float y, float vx, float vy, float _r) {
    p = new PVector(x,y);
    v = new PVector(vx,vy);
    r=_r;
    m=r;
  }
  Ball(float x, float y, float vx, float vy, float _r,float _m) {
    p = new PVector(x,y);
    v = new PVector(vx,vy);
    r=_r;
    m=_m;
  }

  void upd() {
    v.add(g);
    v.mult(airDrag);
    p.add(v);

    PVector tmpP = new PVector(p.x,p.y);
    p.x = constrain(p.x,r,w-r);
    p.y = constrain(p.y,r,h-r);
    if(p.x!=tmpP.x) {
      v.x = -v.x;
      v.mult(frameDrag);
    }
    if(p.y!=tmpP.y) {
      v.y = -v.y;
      v.mult(frameDrag);
    }
  }

  void render() {
    ellipseMode(CENTER);
    noFill();
    strokeWeight(3);
    stroke(0);
    ellipse(p.x,p.y,r*2,r*2);
  }
}

boolean marking = false;

void keyPressed() {

  if(key== 'b') bs.add(new Ball(mouseX,mouseY,mouseX-pmouseX,mouseY-pmouseY,30,500));
  if(key== 'd') {
    int tmp = 0;
    mouseR=20;
    marking = true;
    for(int i=0;i<s-tmp;i++) {
      Ball b= ((Ball) bs.get(i));
      float dx=b.p.x-mouseX;
      float dy=b.p.y-mouseY;
      float d2=sq(dx)+sq(dy);
      if(d2<sq(b.r+mouseR)) {
        bs.remove(i);
        tmp ++;
      }
    }
  }
  if(key=='s') {
    mouseR=200;
    marking = true;
    for(int i=0;i<s;i++) {
      Ball b= ((Ball) bs.get(i));
      float dx=b.p.x-mouseX;
      float dy=b.p.y-mouseY;
      float d2=sq(dx)+sq(dy);
      if(d2<sq(b.r+mouseR)) {
        b.v.mult(0.5);
      }
    }
  }
}

void keyExtras(){
  if(marking && keyPressed) {
    noStroke();
    fill(0,100);
    ellipse(mouseX,mouseY,mouseR*2,mouseR*2);
  }
  else marking = false;
}
