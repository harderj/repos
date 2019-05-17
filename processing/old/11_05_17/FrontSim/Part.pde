class Part{
  
  int updateNum;
  float[] rx, ry, rvx, rvy;
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
    rx=new float[memSize];
    ry=new float[memSize];
    rvx=new float[memSize];
    rvy=new float[memSize];
    updateNum = 0;
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
    rx[updateNum%memSize]=x;
    ry[updateNum%memSize]=y;
    rvx[updateNum%memSize]=vx;
    rvy[updateNum%memSize]=vy;
    
    render();
    trace(2,0.99);
    updateNum ++;
  }
  
  void render(){
    noStroke();
    fill(0);
    ellipse(x,y,siz,siz);
  }
  
  void trace(int weight, float fader){
    noFill();
    stroke(0);
    strokeWeight(weight);
    for(int i=0; i<constrain(updateNum,0,memSize-1); i++){
      int n = (updateNum-i)%memSize;
      int n_1;
      if(n!=0) n_1 = n-1;
      else n_1 = memSize-1;
      stroke(0,255*pow(fader,i));
      line(rx[n], ry[n], rx[n_1], ry[n_1]);
    }
  }
  
}
