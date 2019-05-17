class Ball{
  PVector p,v;
  int ID = 0;
  int t = 0;
  float r = ballR;
  float m = 1;
  
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
        float d2 = sq(dp.x)+sq(dp.y); // squared distance
        float rsum = r+b.r;
        if(d2 < sq(rsum)){
          keepDist(this,b);
          newVel(this,b);
          
          float vm = sqrt(sq(v.x)+sq(v.y));
          float bvm = sqrt(sq(b.v.x)+sq(b.v.y));
          float va = atan2(v.y,v.x);
          float bva = atan2(b.v.y,b.v.x);
          float f;
          if(t!=b.t) f = speedUp;
          else f = speedDown;
          
          v.x = cos(va)*constrain(vm+f,0,maxVel);
          v.y = sin(va)*constrain(vm+f,0,maxVel);
          b.v.x = cos(bva)*constrain(bvm+f,0,maxVel);
          b.v.y = sin(bva)*constrain(bvm+f,0,maxVel);
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
