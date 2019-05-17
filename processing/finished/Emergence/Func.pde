void keepDist(Ball b1, Ball b2){
  float dx=b2.p.x-b1.p.x;
  float dy=b2.p.y-b1.p.y;
  float rsum =b1.r+b2.r;
  float d2=sq(dx)+sq(dy);
  float d = sqrt(d2);
  float a=atan2(dy,dx);
  float dd = rsum-d;
  b1.p.x += cos(a+PI)*dd*0.5;
  b1.p.y += sin(a+PI)*dd*0.5;
  b2.p.x += cos(a)*dd*0.5;
  b2.p.y += sin(a)*dd*0.5;
}

void newVel(Ball b1, Ball b2) {
  float dx=b2.p.x-b1.p.x;
  float dy=b2.p.y-b1.p.y;
  float d2=sq(dx)+sq(dy);
  
  PVector v_n = new PVector(dx,dy);
  float hyp = sqrt(d2);
  PVector v_un = new PVector(dx/hyp,dy/hyp);
  PVector v_ut = new PVector(-v_un.y,v_un.x);

  float v1n = v_un.dot(b1.v);
  float v1tPrime = v_ut.dot(b1.v);
  float v2n = v_un.dot(b2.v);
  float v2tPrime = v_ut.dot(b2.v);

  float v1nPrime = (v1n*(b1.m-b2.m) + 2*b2.m*v2n)/(b1.m+b2.m);
  float v2nPrime = (v2n*(b2.m-b1.m) + 2*b1.m*v1n)/(b1.m+b2.m);

  PVector v_v1nPrime = new PVector(v_un.x*v1nPrime, v_un.y*v1nPrime);
  PVector v_v1tPrime = new PVector(v_ut.x*v1tPrime, v_ut.y*v1tPrime);
  PVector v_v2nPrime = new PVector(v_un.x*v2nPrime, v_un.y*v2nPrime);
  PVector v_v2tPrime = new PVector(v_ut.x*v2tPrime, v_ut.y*v2tPrime);

  b1.v.x = v_v1nPrime.x + v_v1tPrime.x;
  b1.v.y = v_v1nPrime.y + v_v1tPrime.y;
  b2.v.x = v_v2nPrime.x + v_v2tPrime.x;
  b2.v.y = v_v2nPrime.y + v_v2tPrime.y;
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
