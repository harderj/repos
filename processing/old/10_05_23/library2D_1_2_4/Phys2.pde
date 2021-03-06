class Phys2{

  Point2 p, v, a;
  float m, r;

  Phys2(){
    p = new Point2();
    v = new Point2();
    a = new Point2();
    m = 1;
    r = 0;
  }

  void update(){
    v.add(a);
    a.setZero();
    p.add(v);
  }
  
  // change
  
  void addAcc(float x, float y){
    a.x += x/m;
    a.y += y/m;
  }
  
  void addAcc(Point2 acc){
    a.x += acc.x/m;
    a.y += acc.y/m;
  }
  
  void addAccInDirection(float acc, float direction){
    float tAcc = acc/m;
    a.x += cos(direction)*tAcc;
    a.y += sin(direction)*tAcc;
  }

}

