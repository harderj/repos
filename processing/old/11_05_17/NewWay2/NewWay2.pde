void setup() {
  size(400,400);
}

float dt = 0.1;
float t = 1;
State s1 = new State(new Vect(0,100),0);
State s2 = new State(new Vect(0,100),0);

void draw() {
  background(255);
  
  // RK4
  
  RK4(s1,t,dt);
  noStroke();
  fill(0);
  ellipse(width*0.5+s1.x,height*0.3,10,10);
  
  // EULER
  
  EULER(s2,t,dt);
  noStroke();
  fill(0);
  ellipse(width*0.5+s2.x,height*0.7,10,10);
  
  int left = 3;
  int right = 10;
  println(nfp((s1.x-s2.x),left,right) + "    " + nfp((s1.v-s2.v),left,right));
  
  t+=dt;
}


Vect acceleration(State state, float t) {
  float k = 1;
  float b = 0.1;
  return new Vect(-k * state.z.x - b*state.v.x, 0);
}

