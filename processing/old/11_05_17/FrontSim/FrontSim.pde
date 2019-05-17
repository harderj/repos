//graphic
float siz = 15;
int fader = 255;

//simic
float kG=0.1;
float kT=0.001;
float dt=0.2;
int num=5;
int memSize = 1000;

//general
Part[] ps;

void setup() {
  size(595,842);
  smooth();
  background(255);
  ellipseMode(CENTER);

  ps = new Part[num];
  float r=width*0.4;
  float magn=38/2;
  float deg = TWO_PI / (float)num;
  for(int i=0; i<num; i++) {
    float ang = deg*i;
    float x = cos(ang)*r;
    float y = sin(ang)*r;
    float vx = cos(ang+PI*0.5)*magn;
    float vy = sin(ang+PI*0.5)*magn;
    ps[i]=new Part(x, y, vx, vy, 10/num);
  }
}

void draw() {
  noStroke();
  fill(255,fader);
  rect(-20,-20,width+40,height+40);
  translate(width*0.5,height*0.5);
  scale(1);

  for(int i=0; i<num; i++) setAcc(ps[i],ps[(i+1)%num]);
  for(int i=0; i<num; i++) ps[i].update(dt);
}

void setAcc(Part p1, Part p2) {
  float dx = (p1.x-p2.x)*kT;
  float dy = (p1.y-p2.y)*kT;
  float dist2 = dx*dx+dy*dy;
  float idist2 = 1/dist2;
  float ang = atan2(dy, dx);//180/PI*atan( (dy/dx) );
  float sinu = sin(ang);
  float cosi = cos(ang);

  p1.ax += -idist2*cosi*p2.m*kG;
  p1.ay += -idist2*sinu*p2.m*kG;
  p2.ax += idist2*cosi*p1.m*kG;
  p2.ay += idist2*sinu*p1.m*kG;
}

void keyPressed() {
  if(key=='p') saveFrame();
}

