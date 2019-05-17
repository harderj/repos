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

class State {
  Vect z, v;
  State() {
    z = new Vect();
    v = new Vect();
  }
  State(Vect _z) {
    z = _z;
    v = new Vect();
  }
  State(Vect _z, Vect _v) {
    z = _z;
    v = _v;
  }
}

class Derivative {
  Vect dz, dv;
  Derivative() {
    dz = new Vect();
    dv = new Vect();
  }
  Derivative(Vect _dz) {
    dz = _dz;
    dv = new Vect();
  }
  Derivative(Vect _dz, Vect _dv) {
    dz = _dz;
    dv = _dv;
  }
}
