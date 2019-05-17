class Phys2{
  
  Point2 p, v, a;
  
  Phys2(){
    p = new Point2();
    v = new Point2();
    a = new Point2();
  }
  
  void update(){
    v.add(a);
    a.setZero();
    p.add(v);
  }
  
}
