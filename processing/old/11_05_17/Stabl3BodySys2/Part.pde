class Part{
  
  float x, y, vx, vy, ax, ay, m, im, qm;

  Part(){
    standard();
  }

  Part(float _x, float _y){
    standard();
    x=_x;
    y=_y;
  }
  
  Part(float _x,float _y,float _vx,float _vy){
    standard();
    x=_x;
    y=_y;
    vx=_vx;
    vy=_vy;
    calcMassVars();
  }
  
  Part(float _x,float _y,float _vx,float _vy,float _m){
    standard();
    x=_x;
    y=_y;
    vx=_vx;
    vy=_vy;
    m=_m;
    calcMassVars();
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

  void update(float dt){
    vx+=ax*dt;
    vy+=ay*dt;
    x+=vx*dt;
    y+=vy*dt;
    ax=.0;
    ay=.0;
    
    render();
  }
  
  void render(){
    noStroke();
    fill(0);
    ellipse(x,y,siz,siz);
  }
  
}
