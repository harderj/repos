PVector orthogonality(PVector vector, float a, float b){
  PVector p = new PVector(vector.x, vector.y);
  
  setRotation(p, 0);
  
  
  return p;
}

PVector setRotation(PVector vector, float a){
  PVector p = new PVector(vector.x, vector.y);
  
  float l = sqrt(p.x*p.x + p.y*p.y);
  p.x = l*cos(a);
  p.y = l*sin(a);
  
  return p;
}

PVector addRotation(PVector vector, float a){
  PVector p = new PVector(vector.x, vector.y);
  
  float l = sqrt(p.x*p.x + p.y*p.y);
  float b = atan2(p.y, p.x);
  p.x = l*cos(a+b);
  p.y = l*sin(a+b);
  
  return p;
}

float average(float[] l){
  float a = 0;
  
  for(int i=0; i<l.length; i++){
    a += l[i];
  }
  a /= l.length;

  return a;  
}

PVector average(PVector[] l){
  float x = 0;
  float y = 0;

  for(int i=0; i<l.length; i++){
    x += l[i].x;
    y += l[i].y;
  }

  x /= l.length;
  y /= l.length;

  return new PVector(x,y);
}

PVector average(PVector a, PVector b){
  PVector[] l = {
    new PVector(a.x, a.y),
    new PVector(b.x, b.y)
  };
  
  float x = 0;
  float y = 0;

  for(int i=0; i<l.length; i++){
    x += l[i].x;
    y += l[i].y;
  }

  x /= l.length;
  y /= l.length;

  return new PVector(x,y);
}

PVector average(PVector a, PVector b, PVector c){
  PVector[] l = {
    new PVector(a.x, a.y),
    new PVector(b.x, b.y),
    new PVector(c.x, c.y)
  };
  
  float x = 0;
  float y = 0;

  for(int i=0; i<l.length; i++){
    x += l[i].x;
    y += l[i].y;
  }

  x /= l.length;
  y /= l.length;

  return new PVector(x,y);
}

void spot(float x, float y){
  float v = 0.3;
  //ellipse(x*s,y*s,20,20);
  line(x*s+s*v,y*s+s*v,x*s-s*v,y*s-s*v);
  line(x*s+s*v,y*s-s*v,x*s-s*v,y*s+s*v);
}

void spot(PVector a){
  float v = 0.3;
  //ellipse(x*s,y*s,20,20);
  line(a.x*s+s*v,a.y*s+s*v,a.x*s-s*v,a.y*s-s*v);
  line(a.x*s+s*v,a.y*s-s*v,a.x*s-s*v,a.y*s+s*v);
}

void linearFunc(float a, float b){
  line(-sX*s, (a*-sX+b)*s, sX*s, (a*sX+b)*s);
}
