class Vect {
  float x,y;
  Vect() {
    x=0;
    y=0;
  }
  Vect(float _x, float _y) {
    x = _x;
    y = _y;
  }
  Vect(Vect v) {
    x = v.x;
    y = v.y;
  }
}

class Part {
  float m =1;
  Vect z, v;
  Part() {
    z = new Vect();
    v = new Vect();
  }
  Part(Vect _z) {
    z = _z;
    v = new Vect();
  }
  Part(Vect _z, Vect _v) {
    z = _z;
    v = _v;
  }
}
