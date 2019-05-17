class Ball{
  PVector p,v;
  int ID = 0;
  int t = 0;
  
  Ball(int i){
    p=new PVector(random(width), random(height));
    float a=random(TWO_PI);
    float m=random(2)+1;
    v=new PVector(cos(a)*m, sin(a)*m);
    ID = i;
    if(ID < 15) t = 0;
    else t = 1;
  }
  
  void updatePosVel(){
    p.add(v);
    PVector m = new PVector(ballR,ballR);
    PVector M = new PVector(width-ballR,height-ballR);
    if(!inside(p.x,m.x,M.x)){
      v.x *= -1;
      p.x = constrain(p.x,m.x,M.x);
    }
    if(!inside(p.y,m.y,M.y)){
      v.y *= -1;
      p.y = constrain(p.y,m.y,M.y);
    }
  }
  
  void checkBalls(){
    for(int i=0; i<balls.size();i++){
      Ball b = ((Ball) balls.get(i));
      if(b.ID != ID){
        PVector dp = new PVector(b.p.x-p.x,b.p.y-p.y); //delta position
        float sqdist = sq(dp.x)+sq(dp.y); // squared distance
        if(sqdist < sq(ballR*2)){
          float a = atan2(-dp.y,-dp.x); //angle
          PVector mp = new PVector(p.x+dp.x*0.5,p.y+dp.y*0.5); // midpoint between positions
          p.x = mp.x+cos(a)*ballR;
          p.y = mp.y+sin(a)*ballR;
          b.p.x = mp.x+cos(PI+a)*ballR;
          b.p.y = mp.y+sin(PI+a)*ballR;
          
          float av = atan2(v.y,v.x); // angle of velocity
          float bav = atan2(b.v.y,b.v.x); // other ball's angle of velocity
          float vm = sqrt(sq(v.x)+sq(v.y)); // velocity magnitude
          float bvm = sqrt(sq(b.v.x)+sq(b.v.y)); // other ball's velocity magnitude
          
          /*
          float ar = a; //angle reflected in
          v.x = cos(ar)*vm;
          v.y = sin(ar)*vm;
          b.v.x = cos(PI+ar)*vm;
          b.v.y = sin(PI+ar)*vm;
          */
          
          float fp; // factor
          if(t==b.t) fp = -0.1;
          else fp = 0.05;
          v.x += cos(av)*constrain(vm,0,maxV)*fp;
          v.y += sin(av)*constrain(vm,0,maxV)*fp;
          b.v.x += cos(bav)*constrain(bvm,0,maxV)*fp;
          b.v.y += sin(bav)*constrain(bvm,0,maxV)*fp;
        }
      }
    }
  }
  
  void render(){
    noStroke();
    if(t==0)fill(255,0,0);
    if(t==1)fill(0,255,0);
    if(t==2)fill(0,0,255);
    ellipseMode(CENTER);
    ellipse(p.x,p.y,ballR*2,ballR*2);
  }
}

boolean inside(float v, float m, float M){
  if(v>m && v<M) return true;
  else return false;
}

boolean insideScreen(PVector p, float r){
  float w=screen.width;
  float h=screen.height;
  if(p.x>0+r && p.x<w-r && p.y>0+r && p.y<h-r) return true;
  else return false;
}

boolean insideScreen(PVector p){
  float w=width;
  float h=height;
  if(p.x>0 && p.x<w && p.y>0 && p.y<h) return true;
  else return false;
}

boolean insideRect(PVector v, PVector m, PVector M){
  PVector tmpV = new PVector(v.x-m.x,v.y-m.y);
  PVector tmpM = new PVector(M.x-m.x,M.y-m.y);
  if(inside(tmpV.x,m.x,M.x) && inside(tmpV.y,m.y,M.y)) return true;
  else return false;
}

PVector constrain(PVector v, PVector m, PVector M){
  return new PVector(constrain(v.x,m.x,M.x),constrain(v.y,m.y,M.y));
}
