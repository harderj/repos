class Point2 extends Vect2{

  // BASE VARIABLES

  // CONSTRUCTORS

  Point2(){
    super();
  }

  Point2(float x, float y){
    super(x, y);
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
    float factor = 0.01;
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    point(x, y);
    strokeWeight((width+height)*0.5*factor*0.5);
    stroke(0);
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

