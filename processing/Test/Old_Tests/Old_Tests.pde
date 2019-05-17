

Vect a;
float A;

void setup(){
  a = new Vect(3,4);
  A = 0;
  tis(a, A);
}

void draw(){
}

void tis(Vect b, float B){
  float C = B;
  C++;
  print("Float data: A-" + A + ", B-");
  print(B + ", C-");
  println(C);
  Vect c = b;
  Vect d = c;
  Vect e = d;
  c.div(10);
  a.mult(10);
  a.debug("A");
  b.debug("B");
  c.debug("C");
  d.debug("D");
  e.debug("E");
}
