
import point2line.*;

class Poly2{

  // BASE VARIABLES

  Point2[] p;

  // CONSTRUCTORS

  Poly2(int length){
    p = new Point2[length];
  }

  Poly2(Point2[] points){
    p = points;
  }

  // SETTING WITH INPUT

  void transpose(Point2 v){
    for(int i=0; i<p.length; i++) p[i].add(v);
  }

  void scale(float a){
    for(int i=0; i<p.length; i++) p[i].scale(a);
  }

  void divide(float a){
    for(int i=0; i<p.length; i++) p[i].divide(a);
  }

  void rotateAroundAveragePosition(float a){ // not tested
    for(int i=0; i<p.length; i++) p[i].setRotationAround(averagePosition(), a);
  }

  // SETTING WITHOUT INPUT

  void setRandomScreen(){
    for(int i=0; i<p.length; i++) p[i] = randomPoint2Screen();
  }
  
  void setRandomScreenNatural(){ 
    // Scrambles all points in the polygon while making sure that all points are inside the screen, and that the polygon is not "self intersecting" (see function "selfIntersecting")
    // NOTE - can become really heavy or even crash if the number of points is high (roughly above 25)
    for(int i=0; i<p.length; i++) p[i] = randomPoint2Screen();
    while(selfIntersecting()) for(int i=0; i<p.length; i++) p[i] = randomPoint2Screen();
  }

  // RETURNING WITH INPUT

  boolean containPoint(Point2 v){
    int t = 0; 
    float[] a = new float[p.length];
    float[] b = new float[p.length];
    for(int i=0; i<p.length; i++){
      Line2 tLine = new Line2(p[i], p[(i+1)%p.length]);
      a[i] = tLine.tilt();
      b[i] = tLine.offset();

      float intersectX = -((b[i]-v.y)/a[i]);

      if(v.x > intersectX && insideInterval(v.y, p[i].y , p[(i+1)%p.length].y)) t++;
    }

    if(t%2 == 0) return false; // if the polygon's lines has intersected the x-line an even count before reaching mouseX, false is returned, else true
    else return true;
  }

  // RETURNING WITHOUT INPUT

  boolean selfIntersecting(){
    // Returns true, if two or more of the abstract/drawable lines between the polygon's point are intersecting
    // Returns (for mathimatical reasons) always false, if the number of points in the polygon are below 4 
    // NOTE - does always not work if two or more vertices has the exactly same positions slash Point2-values
    Line2[] l = new Line2[p.length];
    for(int i=0; i<p.length; i++){
      l[i] = new Line2(p[i], p[(i+1)%p.length]);
    }

    if(intersectingMultipleLines(l)) return true;
    else return false;
  }

  Point2 averagePosition(){
    Point2 a = new Point2();
    for(int i=0; i<p.length; i++) a.add(p[i]);
    a.divide(p.length);
    return a;
  }

  // NEITHER RETURNING NOR SETTING

  void render(){
    beginShape();
    for(int i=0; i<p.length; i++) vertex(p[i].x, p[i].y);
    endShape();
  }

  void renderFill(){
    beginShape();
    for(int i=0; i<p.length; i++) vertex(p[i].x, p[i].y);
    endShape(CLOSE);
  }

  void renderAuto(){
    float factor = 0.01;
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    fill(0,255*0.5);
    beginShape();
    for(int i=0; i<p.length; i++) vertex(p[i].x, p[i].y);
    endShape(CLOSE);
  }

  void renderAuto(float factor){
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    fill(0,255*0.5);
    beginShape();
    for(int i=0; i<p.length; i++) vertex(p[i].x, p[i].y);
    endShape(CLOSE);
  }
}



class Point2 extends Vect2{

  // BASE VARIABLES

  // CONSTRUCTORS

  Point2(){
    this.x = 0;
    this.y = 0;
  }

  Point2(float x, float y){
    this.x = x;
    this.y = y;
  }

  // SETTING WITH INPUT

  void rotateAround(Point2 around, float angle){
    subtract(around);
    float tmpMagnitude = magnitude();
    float tmpAngle = atan2(y, x);
    set(around.x + cos(tmpAngle+angle)*tmpMagnitude, around.y + sin(tmpAngle+angle)*tmpMagnitude);
  }

  void setRotationAround(Point2 around, float angle){
    subtract(around);
    float tmpMagnitude = magnitude();
    set(around.x + cos(angle)*tmpMagnitude, around.y + sin(angle)*tmpMagnitude);
  }

  void reflect(Point2 reflector){
    float a = atan2(y, x);
    float b = atan2(reflector.y, reflector.x);
    float c = 2*b-a;

    setRotation(c);
  }

  // SETTING WITHOUT INPUT

  void setRandomScreen(){
    x = random(width);
    y = random(height);
  }

  // RETURNING WITH INPUT

  boolean equals(Point2 p){
    if(x == p.x && y == p.y) return true;
    else return false;
  }

  boolean insideCircle(Point2 v, float r){
    Point2 d = new Point2();
    d.x = x-v.x;
    d.y = y-v.y;
    if(d.x*d.x+d.y*d.y < r*r) return true;
    else return false;
  }

  boolean insideRect(Point2 min, Point2 max){
    if(x >= min(min.x, max.x) && x <= max(min.x, max.x) && y >= min(min.y, max.y) && y <= max(min.y, max.y)) return true;
    else return false;
  }

  boolean insidePolygon(Point2[] p){
    int t = 0; 
    float[] a = new float[p.length];
    float[] b = new float[p.length];
    for(int i=0; i<p.length; i++){
      Line2 tLine = new Line2(p[i], p[(i+1)%p.length]);
      a[i] = tLine.tilt();
      b[i] = tLine.offset();

      float intersectX = -((b[i]-y)/a[i]);

      if(x > intersectX && insideInterval(y, p[i].y , p[(i+1)%p.length].y)) t++;
    }

    if(t%2 == 0) return false; // if the polygon's lines has intersected the x-line an even count before reaching mouseX, false is returned, else true
    else return true;
  }
  
  float angleBetween(Point2 p){
    return atan2(p.y-y,p.x-x);
  }

  Point2 reflected(Point2 reflector){
    Point2 result = this.copy();

    float a = atan2(y, x);
    float b = atan2(reflector.y, reflector.x);
    float c = 2*b-a;

    result.setRotation(c);

    return result;
  }

  // RETURNING WITHOUT INPUT

  Point2 copy(){
    return new Point2(x, y);
  }

  boolean insideScreen(){
    if(x >= 0 && x <= width && y >= 0 && y <= height) return true;
    else return false;
  }

  // NEITHER SETTING NOR RETURNING

  void render(){
    point(x, y);
  }

  void renderAuto(){
    float factor = 0.05;
    strokeWeight((width+height)*0.5*factor);
    stroke(255,100);
    point(x, y);
    strokeWeight((width+height)*0.5*factor*0.5);
    stroke(0,100);
    point(x, y);
  }

  void renderAuto(float factor){
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    point(x, y);
    strokeWeight((width+height)*0.5*factor*0.5);
    stroke(0);
    point(x, y);
  }
}



class Phys2{

  Point2 p, v, a;
  float m, r;
  float rv; // new

  Phys2(){
    p = new Point2();
    v = new Point2();
    a = new Point2();
    m = 1;
    r = 0;
    rv = 0;
  }
  
  Phys2(Point2 pos){
    p = pos.copy();
    v = new Point2();
    a = new Point2();
    m = 1;
    r = 0;
    rv = 0; // new
  }

  void update(){
    r += rv; // new
    r *= DRAG; // new
    v.add(a);
    a.setZero();
    v.mult(DRAG);
    p.add(v);
  }
  
  // change
  
  void addAcc(float x, float y){
    a.x += x/m;
    a.y += y/m;
  }
  
  void addAcc(Point2 acc){
    a.x += acc.x/m;
    a.y += acc.y/m;
  }
  
  void addAccInDirection(float acc, float direction){
    float tAcc = acc/m;
    
    a.x += cos(direction)*tAcc;
    a.y += sin(direction)*tAcc;
  }

}


class Line2{
  
  // BASE VARIABLES
  
  Point2 p1, p2;

  // CONSTRUCTORS

  Line2(Point2 p1, Point2 p2){
    this.p1 = p1;
    this.p2 = p2;
  }
  
  // SETTING WITH INPUT

  void set(Point2 p1, Point2 p2){
    this.p1 = p1;
    this.p2 = p2;
  }

  void add(Point2 v){
    p1.add(v);
    p2.add(v);
  }

  void sub(Point2 v){
    p1.subtract(v);
    p2.subtract(v);
  }
  
  // SETTING WITHOUT INPUT
  
  // RETURNING WITH INPUT
  
  boolean sharesPointWithLine(Line2 l){
    // Returns true, if the one or two end-points of the two lines (it self and the input) has the exact same positions
    if(p1.equals(l.p1) || p1.equals(l.p2) || p2.equals(l.p1) || p2.equals(l.p2)) return true;
    else return false;
  }
  
  boolean equals(Line2 l){
    if(p1.equals(l.p1) && p2.equals(l.p2)) return true;
    else return false;
  }
  
  boolean intersectingLine(Line2 l){
    Point2 inter = intersectionLine(l);

    if(inter.insideRect(p1, p2) && inter.insideRect(l.p1, l.p2)) return true;
    else return false;
  }
  
  Point2 intersectionLine(Line2 l){
    Point2 result = new Point2();

    float a1 = tilt();
    float b1 = offset();
    float a2 = l.tilt();
    float b2 = l.offset();

    result.x = -1*((b1-b2)/(a1-a2));
    result.y = a1*result.x+b1;

    return result;
  }
  
  // RETURNING WITHOUT INPUT
  
  float tilt(){
    return (p1.y-p2.y)/(p1.x-p2.x);
  }

  float offset(){
    return p1.y-(p1.x*tilt());
  }
  
  float length(){
    return sqrt(sq(p1.x-p2.x)+sq(p1.y-p2.y));
  }
  
  float squareLength(){
    // Far more fast than the similar function "length()", because it doesn't have to calculate a square root
    return (sq(p1.x-p2.x)+sq(p1.y-p2.y));
  }
  
  // NEITHER SETTING NOR RETURNING
  
  void render(){
    line(p1.x, p1.y, p2.x, p2.y);
  }

  void renderAuto(){
    float factor = 0.01;
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    line(p1.x, p1.y, p2.x, p2.y);
    strokeWeight((width+height)*0.5*factor*0.5);
    stroke(0);
    line(p1.x, p1.y, p2.x, p2.y);
  }

  void renderAuto(float factor){
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    line(p1.x, p1.y, p2.x, p2.y);
    strokeWeight((width+height)*0.5*factor*0.5);
    stroke(0);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
  void renderGraph(){
    line(0,offset(),width,tilt()*width+offset());
  }
}


boolean searchString(String searchFor, String searchIn){
  // Searches for a specific string, inside another string
  // Returns 'true' if found, 'false' if not
  // If the string searched in is shorter than the one searched for, 'false' will return
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

float inbound(float value, float minimum, float maximum){
  // Keeps a value between a minimum and a maximum by recounting
  while(value>maximum){
    value -= maximum - minimum;
  }

  while(value<minimum){
    value += maximum - minimum;
  }

  return value;
}

boolean insideInterval(float a, float b, float c){
  if(a >= min(b,c) && a <= max(b,c)) return true;
  else return false;
}

color negative(color c){
  return color(255-red(c), 255-green(c), 255-blue(c));
}

Point2 randomPoint2Screen(){
  return new Point2(random(width), random(height));
}

boolean intersectingMultipleLines(Line2[] l){
  // If any line in the list is intersecting : returns true
  // NOTE - see the function "selfIntersecting()" in the class "Poly2"
  boolean result = false;
  for(int i=0; i<l.length; i++){
    for(int j=0; j<l.length; j++){
      if(!l[i].equals(l[j]) && !l[i].sharesPointWithLine(l[j]) && l[i].intersectingLine(l[j])){
        result = true;
        break;
      }
    }
  }
  return result;
}

class Force2{

  Phys2[] l;
  float[] p;
  String k;

  Force2(String kind, float[] parameters, Phys2 a, Phys2 b){
    k = kind;
    p = parameters;
    l = new Phys2[2];
    l[0] = a;
    l[1] = b;
  }
  
  Force2(String kind, float[] parameters, Phys2 a, Phys2 b, Phys2 c){
    k = kind;
    p = parameters;
    l = new Phys2[3];
    l[0] = a;
    l[1] = b;
    l[2] = c;
  }

  void update(){
    if(k == "attraction") attraction();
  }

  // ATTRACTION
  //
  // Parameters
  // '0' = acceleration

  void attraction(){
    
    for(int i=0; i<l.length; i++){
      for(int j=0; j<l.length; j++){
        if(i != j) l[i].addAccInDirection(p[0], l[i].p.angleBetween(l[j].p));
      }
    }
  }
}


class Circle2{
  
  // BASE VARIABLES
  
  Point2 p;
  float r;
  
  // CONSTRUCTORS
  
  Circle2(Point2 position, float radius){
    p = position;
    r = radius;
  }
  
  // SETTING WITH INPUT
  
  // SETTING WITHOUT INPUT
  
  // RETURNING WITH INPUT
  
  boolean intersectingCircle(Circle2 c){
    if(p.subtracted(c.p).squareMagnitude() < sq(r+c.r)) return true;
    else return false;
  }
  
  boolean containPoint(Point2 p){
    if(this.p.subtracted(p).squareMagnitude() < sq(r)) return true;
    else return false;
  }
  
  // RETURNING WITHOUT INPUT
  
  // NEITHER RETURNING NOR SETTING
  
  void render(){
    ellipse(p.x, p.y, r*2, r*2);
  }
  
  void renderAuto(){
    float factor = 0.01;
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    fill(0);
    ellipse(p.x, p.y, r*2, r*2);
  }
  
  void renderAuto(float factor){
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    fill(0);
    ellipse(p.x, p.y, r*2, r*2);
  }
}
