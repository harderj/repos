class Part{
  
  double x, y, vx, vy, ax, ay, m, im, qm;
  
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
    ax=0;
    ay=0;
    m=1;
    calcMassVars();
  }
  void calcMassVars(){
    if(m==0){
      im=0;
      qm=1;
    }
    else{
      im=1/m;
      qm=sqrt((float)m);
    }
  }
  
  void update(double dt){
    vx+=ax*dt;
    vy+=ay*dt;
    x+=vx*dt;
    y+=vy*dt;
    ax=.0;
    ay=.0;
  }
  
  void render(float dia){
    ellipseMode(CENTER);
    noStroke();
    ellipse((float)x, (float)y, dia, dia);
    stroke(255);
    noFill();
    strokeWeight(1/scale);
    ellipse((float)x, (float)y,10,10);
  }
  
}
