class Part{

  int trace = 1;
  int mp = 0;
  float[] mx = new float[dataSize];
  float[] my = new float[dataSize];
  float[] mvx = new float[dataSize];
  float[] mvy = new float[dataSize];
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
    mvx[mp%dataSize] = (float)vx;
    mvy[mp%dataSize] = (float)vy;
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

    if(trace == 1){
      beginShape();
      for(int i=0; i<dataSize; i++){
        int tmp = (i+mp)%dataSize;
        if(mx[tmp]!=0 && my[tmp]!=0) vertex(mx[tmp], my[tmp]);
      }
      vertex((float)x,(float)y);
      endShape();
    }
    if(trace == 2){
      beginShape();
      for(int i=0; i<dataSize; i++){
        int tmp = (i+mp)%dataSize;
        if(mx[tmp]!=0 && my[tmp]!=0) vertex((float)p2.x+mx[tmp]-p2.mx[tmp], (float)p2.y+my[tmp]-p2.my[tmp]);
      }
      vertex((float)x,(float)y);
      endShape();
    }
  }

}

