int num = 3;
float dt = 0.1;

float t = 0;
Part[] ps;

void setup() {
  size(400,400);
  smooth();
  ellipseMode(CENTER);
  
  ps = new Part[num];

  resetParts();
  
  ps[0].z.x = 50;
  ps[0].z.y = 20;
  ps[0].v.x = -9;
  ps[0].v.y = 0;
  
  ps[1].z.x = 50;
  ps[1].z.y = 0;
  ps[2].z.x = -50;
  ps[2].z.y = 0;
}

void draw() {
  background(255);
  translate(width*.5,height*.5);

  fill(0);
  noStroke();
  RK4(ps[0], t, dt);
  for(int i=0;i<num;i++) {
    ps[i].render();
  }
  
  t+=dt;
  println(frameRate);
}

Vect acceleration(Part state, float t) {
  Vect acc = new Vect();

  for(int i=0;i<num;i++) {
    float dx = ps[i].z.x-state.z.x;
    float dy = ps[i].z.y-state.z.y;
    Vect delta = new Vect(dx, dy);
    float dist2 =  delta.x*delta.x + delta.y*delta.y;
    if(dist2 > 5) {
      float f = 1000/(dist2);
      float angle = atan2(delta.y, delta.x);
      Vect F = new Vect(cos(angle)*f,sin(angle)*f);
      //F.mult(0.01);
      acc.add(F);
    }
  }

  return new Vect(acc);
}

void resetParts() {
  float r = 50;
  float s = 10;
  float ang = (TWO_PI/num);
  for(int i=0;i<num;i++) {
    Vect z = new Vect(cos(ang*i)*r, sin(ang*i)*r);
    Vect v = new Vect(cos(HALF_PI+ang*i)*s, sin(HALF_PI+ang*i)*s);
    ps[i] = new Part(z,v);
  }
}

