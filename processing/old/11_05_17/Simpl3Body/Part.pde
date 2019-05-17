class Part{
  
  PVector p, v, a;
  float m, im, qm = 0;
  
  Part(PVector _p, PVector _v, PVector _a){
    p = new PVector(_p.x, _p.y, _p.z);
    v = new PVector(_v.x, _v.y, _v.z);
    a = new PVector(_a.x, _a.y, _a.z);
    m = 1;
    im = 1/m;
  }
  
  Part(PVector _p){
    p = new PVector(_p.x, _p.y, _p.z);
    v = new PVector();
    a = new PVector();
    m = 1;
    im = 1/m;
  }
  
  Part(PVector _p, PVector _v){
    p = new PVector(_p.x, _p.y, _p.z);
    v = new PVector(_v.x, _v.y, _v.z);
    a = new PVector();
    m = 1;
    im = 1/m;
  }
  
  Part(float vel, float ang, float _m){
    p = new PVector(random(width)*0.5 + width*0.25, random(height)*0.5+height*0.25);
    v = new PVector(cos(ang)*vel, sin(ang)*vel, 0);
    a = new PVector();
    m = _m;
    im = 1/m;
  }
  
  Part(PVector _p, float vel, float ang, float _m){
    p = new PVector(_p.x, _p.y);
    v = new PVector(cos(ang)*vel, sin(ang)*vel, 0);
    a = new PVector();
    m = _m;
    im = 1/m;
  }
  
  Part(PVector _p, PVector _v, float _m){
    p = new PVector(_p.x, _p.y, _p.z);
    v = new PVector(_v.x, _v.y, _v.z);
    a = new PVector();
    m = _m;
    im = 1/m;
  }
  
  void draw(){
    
    v.add(a);
    a.set(0,0,0);
    p.add(v);
    
  }
  
  void render(){
    if(qm==0) qm = sqrt(m);
    ellipseMode(CENTER);
    //fill(255);
    noStroke();
    ellipse(p.x, p.y, qm*PI, qm*PI);
  }
  
}
