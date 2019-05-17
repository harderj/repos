class Ball{
  
  PVector p, v, a, rp, rv, ra;
  float r;
  
  Ball(){
    p = new PVector();
    v = new PVector();
    a = new PVector();
    rp = new PVector();
    rv = new PVector();
    ra = new PVector();
  }
  
  void update(){
    
    v.add(a);
    a.set(0,0,0);
    p.add(v);
    
  }
  
  void render(){
    pushMatrix();
    translate(p.x,p.y,p.z);
    rotate(rp.x, rp.y, rp.z, 0);
    sphere(r);
    popMatrix();
  }
}
