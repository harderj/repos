int num = 3;
Part[] ps;

void setup() {
  size(400,400);
  
  ps = new Part[num];
}

float dt = 0.1;
float t = 1;
Part s1 = new Part(new Vect(50,20), new Vect(-9,0));
Part s2 = new Part(new Vect(50,20), new Vect(-9,0));

void draw() {
  background(255);
  translate(width*0.5,height*.5);
  
  // RK4
  
  RK4(s1,t,dt);
  noStroke();
  fill(0,255,0);
  ellipse(s1.z.x,s1.z.y,10,10);
  
  // EULER
  
  EULER(s2,t,dt);
  noStroke();
  fill(255,0,0);
  ellipse(s2.z.x,s2.z.y,10,10);
  
  int left = 3;
  int right = 10;
  //println(nfp((s1.x-s2.x),left,right) + "    " + nfp((s1.v-s2.v),left,right));
  
  fill(0);
  ellipse(p1.x,p1.y,10,10);
  ellipse(p2.x,p2.y,10,10);
  
  t+=dt;
}

Vect p1 = new Vect(-50,0);
Vect p2 = new Vect(50,0);

Vect acceleration(Part state, float t) {
  Vect d1 = new Vect(p1.x-state.z.x, p1.y-state.z.y);
  Vect d2 = new Vect(p2.x-state.z.x, p2.y-state.z.y);
  
  float dist21 = sq(d1.x) + sq(d1.y);
  float dist22 = sq(d2.x) + sq(d2.y);
  
  float f1 = 1000/dist21;
  float f2 = 1000/dist22;
  
  float ang1 = atan2(d1.y, d1.x);
  float ang2 = atan2(d2.y, d2.x);
  
  Vect fin = new Vect(f1*cos(ang1) + f2*cos(ang2),f1*sin(ang1) + f2*sin(ang2));
  
  return new Vect(fin.x, fin.y);
}

