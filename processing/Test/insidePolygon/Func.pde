boolean insidePolygon(Vect2 v, Vect2[] p){
  int t = 0;
  float[] a = new float[p.length];
  float[] b = new float[p.length];
  for(int i=0; i<p.length; i++){
    a[i] = lineTilt(p[i], p[(i+1)%p.length]);
    b[i] = lineOffset(p[i], p[(i+1)%p.length]);
    
    float intersectX = -((b[i]-v.y)/a[i]);
    
    if(v.x > intersectX && insideInterval(v.y, p[i].y , p[(i+1)%p.length].y)) t++;
    //if(v.x > intersectX) t++;
  }
  
  if(t%2 == 0) return false;
  else return true;
}

float lineTilt(Vect2 v1, Vect2 v2){
  return (v1.y-v2.y)/(v1.x-v2.x);
}

float lineTilt(float angle){
  return tan(angle);
}

float lineOffset(Vect2 v1, Vect2 v2){
  return v1.y-(v1.x*((v1.y-v2.y)/(v1.x-v2.x)));
}

float lineOffset(Vect2 v, float a){
  return v.y-(v.x*a);
}

boolean insideInterval(float a, float b, float c){
  if(a >= min(b,c) && a <= max(b,c)) return true;
  else return false;
}

boolean insideRect(Vect2 v, Vect2 min, Vect2 max){
  if(v.x >= min.x && v.x <= max.x && v.y >= min.y && v.y <= max.y) return true;
  else return false;
}

boolean insideScreen(Vect2 v){
  if(v.x >= 0 && v.x <= width && v.y >= 0 && v.y <= height) return true;
  else return false;
}

boolean insideCircle(Vect2 v1, Vect2 v2, float r){
  Vect2 v = v1.subtracted(v2);
  if(v.squareMagnitude() < r*r) return true;
  else return false;
}
