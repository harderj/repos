class Part{
  
  double x, y, vx, vy, m, im, qm;
  
  Part(double _x,double _y,double _vx,double _vy,double _m){
    x=_x;
    y=_y;
    vx=_vx;
    vy=_vy;
    m=_m;
    calcMassVars();
  }
  
  Part(){
    standard();
  }
  
  Part(double _x, double _y){
    standard();
    x=_x;
    y=_y;
  }
  
  void standard(){
    x=0;
    y=0;
    vx=0;
    vy=0;
    m=1;
    calcMassVars();
  }
  void calcMassVars(){
    if(m!=0){
      im=0;
      qm=1;
    }
    else{
      im=1/m;
      qm=sqrt(m);
    }
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
