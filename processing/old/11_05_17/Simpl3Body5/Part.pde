class Part{
  
  int mp = 0;
  float[] mx = new float[dataSize];
  float[] my = new float[dataSize];
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
    
    mx[mp%dataSize] = (float)x;
    my[mp%dataSize] = (float)y;
    mp ++;
  }
  
  void render(float dia, color col){
    fill(col);
    ellipseMode(CENTER);
    noStroke();
    ellipse((float)x, (float)y, dia, dia);
    stroke(col);
    noFill();
    strokeWeight(0.5/scale);
    ellipse((float)x, (float)y,10/scale,10/scale);
    
    if(trace){
    beginShape();
    for(int i=0; i<dataSize; i++){
      int tmp = (i+mp)%dataSize;
      if(mx[tmp]!=0 && my[tmp]!=0) vertex(mx[tmp], my[tmp]);
    }
    vertex((float)x,(float)y);
    endShape();
    }
  }
  
}
