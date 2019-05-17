class Part{
  
  PVector p, v, a;
  
  Part(){
    p = new PVector();
    v = new PVector();
    a = new PVector();
  }
  
  Part(PVector _p, PVector _v, PVector _a){
    p = _p;
    v = _v;
    a = _a;
  }
  
  void update(){
    v.add(a);
    p.add(v);
    a.set(0,0,0);
  }
  
  void draw(){
    noStroke();
    fill(125);
    ellipse(p.x, p.y, 10, 10);
  }
  
}
