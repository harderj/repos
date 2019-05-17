// ROTATE AROUND *badly optimized
// adds a rotation to a vector around another vector
PVector rotateAround(PVector vector, PVector around, float angle){
  PVector tmp = new PVector(vector.x, vector.y);
  tmp.sub(around);
  float tmpMagnitude = tmp.mag();
  float tmpAngle = atan2(tmp.y, tmp.x);
  tmp.set(around.x + cos(tmpAngle+angle)*tmpMagnitude, around.y + sin(tmpAngle+angle)*tmpMagnitude, 0);

  return tmp;
}

// SET ROTATION AROUND *badly optimized
// sets a vectors rotation around another vector to a specific angle
PVector setRotationAround(PVector vector, PVector around, float angle){
  PVector tmp = new PVector(vector.x, vector.y);
  tmp.sub(around);
  float tmpMagnitude = tmp.mag();
  tmp.set(around.x + cos(angle)*tmpMagnitude, around.y + sin(angle)*tmpMagnitude, 0);

  return tmp;
}

// SEARCH STRING *badly optimized
// Searches for a specific string, inside another string.
// Returns 'true' if found, 'false' if not.
// If the string searched in is shorter than the one searched for, 'false' will return.
boolean searchString(String searchFor, String searchIn){
  boolean hit = false;
  if(searchFor.length()<searchIn.length()){
    for(int i=0; i<(searchIn.length() - searchFor.length()); i++){
      String tmp = searchIn.substring(i,i+searchFor.length());
      if(tmp.equals(searchFor)){
        hit = true;
      }
    }
  }
  return hit;
}

// INBOUND *not optimized
// keeps a value between a minimum and a maximum by recounting
float inbound(float value, float minimum, float maximum){

  while(value>maximum){
    value -= maximum - minimum;
  }

  while(value<minimum){
    value += maximum - minimum;
  }

  return value;
}

// LINE TILT
// calculates the tilt in a simple line-equation
// returns the value which the y-coordinate can be multiplied with each time x becomes 1 higher. 
// In other words 'a' in the line-equation : a*x+b=y
float lineTilt(Vect2 v1, Vect2 v2){
  return (v1.y-v2.y)/(v1.x-v2.x);
}

float lineTilt(float angle){
  return tan(angle);
}

// LINE OFFSET
// calculates the y-offset in a simple line-equation
// returns the y-coordinate when a line intersects the vertical axis or y-axis
// in other words 'b' in the line-equation : a*x+b=y
float lineOffset(Vect2 v1, Vect2 v2){
  return v1.y-(v1.x*((v1.y-v2.y)/(v1.x-v2.x)));
}

float lineOffset(Vect2 v, float a){
  return v.y-(v.x*a);
}

//INSIDE FUNCTIONS
//determines wether a vector or a value is located inside a polygon, circle, rect, the screen or an interval

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
  
  if(t%2 == 0) return false; // if the polygon's lines has intersected the x-line an even count before reaching mouseX, false is returned, else true
  else return true;
}

boolean insideInterval(float a, float b, float c){
  if(a >= min(b,c) && a <= max(b,c)) return true;
  else return false;
}

boolean insideRect(Vect2 v, Vect2 min, Vect2 max){
  if(v.x >= min(min.x, max.x) && v.x <= max(min.x, max.x) && v.y >= min(min.y, max.y) && v.y <= max(min.y, max.y)) return true;
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

//REFLECT
//reflects a vector relative to another vector

Vect2 reflect(Vect2 reflecting, Vect2 reflector){
  Vect2 result = reflecting.copy();
  
  float a = atan2(reflecting.y, reflecting.x);
  float b = atan2(reflector.y, reflector.x);
  //float c = 2*b-a;
  float c = reflect(a,b);
  
  result.setRotation(c);
  
  return result;
}

float reflect(float a, float b){ // reflects an angle in relation to another angle
  return 2*b-a;
}
