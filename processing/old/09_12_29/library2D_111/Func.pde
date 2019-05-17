// OLD

// ROTATE AROUND *badly optimized
// adds a rotation to a vector around another vector
Vect2 rotateAround(Vect2 vector, Vect2 around, float angle){
  Vect2 tmp = new Vect2(vector.x, vector.y);
  tmp.subtract(around);
  float tmpMagnitude = tmp.magnitude();
  float tmpAngle = atan2(tmp.y, tmp.x);
  tmp.set(around.x + cos(tmpAngle+angle)*tmpMagnitude, around.y + sin(tmpAngle+angle)*tmpMagnitude);

  return tmp;
}

// SET ROTATION AROUND *badly optimized
// sets a vectors rotation around another vector to a specific angle
Vect2 setRotationAround(Vect2 vector, Vect2 around, float angle){
  Vect2 tmp = new Vect2(vector.x, vector.y);
  tmp.subtract(around);
  float tmpMagnitude = tmp.magnitude();
  tmp.set(around.x + cos(angle)*tmpMagnitude, around.y + sin(angle)*tmpMagnitude);

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
  Vect2 d = new Vect2();
  d.x = v1.x-v2.x;
  d.y = v1.y-v2.y;
  if(d.x*d.x+d.y*d.y < r*r) return true;
  else return false;
}

//REFLECT
//reflects a vector relative to another vector
Vect2 reflect(Vect2 reflecting, Vect2 reflector){
  Vect2 result = reflecting.copy();

  float a = atan2(reflecting.y, reflecting.x);
  float b = atan2(reflector.y, reflector.x);
  float c = reflect(a,b);

  result.setRotation(c);

  return result;
}

float reflect(float a, float b){ // reflects an angle in relation to another angle
  return 2*b-a;
}

// NEW

color negative(color c){
  return color(255-red(c), 255-green(c), 255-blue(c));
}

Vect2 randomVect2Screen(){
  return new Vect2(random(width), random(height));
}

boolean equalsVect2(Vect2 v1, Vect2 v2){
  if(v1.x == v2.x && v1.y == v2.y) return true;
  else return false;
}

boolean intersecting(Vect2 v1, Vect2 v2, Vect2 v3, Vect2 v4){
  Vect2 inter = lineIntersection(v1, v2, v3, v4);

  if(insideRect(inter, v1, v2) && insideRect(inter, v3, v4)) return true;
  else return false;
}

Vect2 lineIntersection(Vect2 v1, Vect2 v2, Vect2 v3, Vect2 v4){
  Vect2 result = new Vect2();

  float a1, b1, a2, b2;

  a1 = lineTilt(v1, v2);
  b1 = lineOffset(v1, v2);

  a2 = lineTilt(v3, v4);
  b2 = lineOffset(v3, v4);

  result.x = -1*((b1-b2)/(a1-a2));
  result.y = a1*result.x+b1;

  return result;
}

Vect2 lineIntersection(float a1, float b1, float a2, float b2){
  Vect2 result = new Vect2();

  result.x = -1*((b1-b2)/(a1-a2));
  result.y = a1*result.x+b1;

  return result;
}

void renderVect2(Vect2 v){
  point(v.x, v.y);
}

void renderVect2Auto(Vect2 v){
  float factor = 0.01;
  strokeWeight((width+height)*0.5*factor);
  stroke(255);
  point(v.x, v.y);
  strokeWeight((width+height)*0.5*factor*0.5);
  stroke(0);
  point(v.x, v.y);
}

void renderVect2Auto(Vect2 v, float factor){
  strokeWeight((width+height)*0.5*factor);
  stroke(255);
  point(v.x, v.y);
  strokeWeight((width+height)*0.5*factor*0.5);
  stroke(0);
  point(v.x, v.y);
}

void renderLineGraph(float a, float b){
  line(0,b,width,a*width+b);
}

boolean intersectingMultipleLines(Line2[] l){ // if any line in the list is intersecting : returns true
  
  // NOTE - see the function "selfIntersecting()" in the class "Poly2"
  
  boolean result = false;
  for(int i=0; i<l.length; i++){
    for(int j=0; j<l.length; j++){
      if(!l[i].equals(l[j]) && !l[i].sharesVect2WithLine(l[j]) && l[i].intersectingLine(l[j])){
        result = true;
        break;
      }
    }
  }
  return result;
}

