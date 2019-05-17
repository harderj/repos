
void keepRadius(Ball b1, Ball b2, float r){
  float dx=b2.p.x-b1.p.x;
  float dy=b2.p.y-b1.p.y;
  float msum =b1.m+b2.m;
  float a=atan2(dy,dx);
  float mp1 = b2.m/msum; //ball one's part of the total mass
  float mp2 = b1.m/msum; //ball two's part of the total mass
  float mx=b1.p.x+dx*mp1;
  float my=b1.p.y+dy*mp1;
  
  b1.p.x = mx+cos(a+PI)*r*mp1;
  b1.p.y = my+sin(a+PI)*r*mp1;
  b2.p.x = mx+cos(a)*r*mp2;
  b2.p.y = my+sin(a)*r*mp2;
  
  circleCollision(b1,b2);
}

boolean colliding(Ball b1, Ball b2) {
  float dx=b2.p.x-b1.p.x;
  float dy=b2.p.y-b1.p.y;
  float rsum =b1.r+b2.r;
  float d2=sq(dx)+sq(dy);
  if(d2<sq(rsum)) return true;
  else return false;
}

void keepOutside(Ball b1, Ball b2) {
  float dx=b2.p.x-b1.p.x;
  float dy=b2.p.y-b1.p.y;
  float rsum =b1.r+b2.r;
  float msum =b1.m+b2.m;
  float d2=sq(dx)+sq(dy);
  float d = sqrt(d2);
  float a=atan2(dy,dx);
  float dd = rsum-d;
  float mpart1 = b2.m/msum;
  float mpart2 = b1.m/msum;
  b1.p.x += cos(a+PI)*dd*mpart1;
  b1.p.y += sin(a+PI)*dd*mpart1;
  b2.p.x += cos(a)*dd*mpart2;
  b2.p.y += sin(a)*dd*mpart2;
}

void circleCollision(Ball b1, Ball b2) {
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

