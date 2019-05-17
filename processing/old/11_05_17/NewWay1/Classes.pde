class Vect {
  float x,y;
  State() {
  }
  State(float _x, float _y) {
    x = _x;
    y = _y;
  }
}

class State {
  Vect z, v;
  State() {
  }
  State(Vect _z) {
    z = _z;
  }
  State(Vect _z, Vect _v) {
    x = _z;
    v = _v;
  }
}

class Derivative {
  Vect dz, dv;
  Derivative() {
  }
  Derivative(Vect _dz) {
    dz = _dz;
  }
  Derivative(Vect _dz, Vect _dv) {
    dz = _dz;
    dv = _dv;
  }
}
