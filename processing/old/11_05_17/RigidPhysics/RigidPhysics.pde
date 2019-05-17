
Ball[] b = new Ball[3];

float airDrag =1;
float ballDrag =1;
float frameDrag =1;
PVector g = new PVector(0,0);
float mouseR=20;

float w,h;

void setup() {
  size(700,700);
  smooth();
  background(255);
  w=width;
  h=height;
  
  b[0] = new Ball(w*0.4, h*0.5, 5, 1, 20,1);
  b[1] = new Ball(w*0.6, h*0.5, 0, 0, 20,10);
  b[2] = new Ball(w*0.8, h*0.5, 0, 0, 20,1);
}


void draw() {
  background(255);
  
  ballList(b,"upd");
  keepRadius(b[0],b[1],100);
  keepRadius(b[1],b[2],100);
  ballList(b,"render");
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
    float va = atan2(v.y,v.x);
    line(p.x,p.y,p.x+cos(va)*r,p.y+sin(va)*r);
  }
}

void ballList(Ball[] b, String t){
  if(t=="upd") for(int i=0; i<b.length; i++) b[i].upd();
  if(t=="render") for(int i=0; i<b.length; i++) b[i].render();
}

