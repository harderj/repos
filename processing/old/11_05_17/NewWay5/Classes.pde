
class Part {
  int ID;
  float m =1;
  Vect z, v;
  Part() {
    z = new Vect();
    v = new Vect();
  }
  Part(Vect _z) {
    z = new Vect(_z);
    v = new Vect();
  }
  Part(float _x, float _y) {
    z = new Vect(_x,_y);
    v = new Vect();
  }
  Part(Vect _z, Vect _v) {
    z = new Vect(_z);
    v = new Vect(_v);
  }
  void render(){
    ellipse(z.x,z.y,10,10);
  }
}

class Vect {
  float x,y;
  
  Vect() {
  }
  
  Vect(float _x, float _y) {
    x = _x;
    y = _y;
  }
  
  Vect(Vect v) {
    x = v.x;
    y = v.y;
  }
  
  void add(Vect v){
    x+=v.x;
    y+=v.y;
  }
  void sub(Vect v){
    x-=v.x;
    y-=v.y;
  }
  void mult(float v){
    x*=v;
    y*=v;
  }
  void div(float v){
    x/=v;
    y/=v;
  }
  boolean isZero(){
    if(x==0 && y==0) return true;
    else return false;
  }
}

