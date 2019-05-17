class Point2{

  // BASE VARIABLES

  Vect2 p;

  // CONSTRUCTORS

  Point2(Vect2 position){
    p = position;
  }

  // SETTING WITH INPUT

  void rotateAround(Vect2 around, float angle){
    Vect2 tmp = new Vect2(p.x, p.y);
    tmp.subtract(around);
    float tmpMagnitude = tmp.magnitude();
    float tmpAngle = atan2(tmp.y, tmp.x);
    tmp.set(around.x + cos(tmpAngle+angle)*tmpMagnitude, around.y + sin(tmpAngle+angle)*tmpMagnitude);

    return tmp;
  }

  void setRotationAround(Vect2 around, float angle){
    Vect2 tmp = new Vect2(p.x, p.y);
    tmp.subtract(around);
    float tmpMagnitude = tmp.magnitude();
    tmp.set(around.x + cos(angle)*tmpMagnitude, around.y + sin(angle)*tmpMagnitude);

    return tmp;
  }

  // SETTING WITHOUT INPUT

  void setRandomScreen(){
    p = new Vect2(random(width), random(height));
  }

  // RETURNING WITH INPUT

  boolean equals(Point2 t){
    if(p.x == t.p.x && p.y == t.p.y) return true;
    else return false;
  }

  boolean insideCircle(Vect2 v, float r){
    Vect2 d = new Vect2();
    d.x = p.x-v.x;
    d.y = p.y-v.y;
    if(d.x*d.x+d.y*d.y < r*r) return true;
    else return false;
  }

  boolean insideRect(Vect2 min, Vect2 max){
    if(p.x >= min(min.x, max.x) && p.x <= max(min.x, max.x) && p.y >= min(min.y, max.y) && p.y <= max(min.y, max.y)) return true;
    else return false;
  }

  // RETURNING WITHOUT INPUT

  boolean insideScreen(){
    if(p.x >= 0 && p.x <= width && p.y >= 0 && p.y <= height) return true;
    else return false;
  }

  // NEITHER SETTING NOR RETURNING

  void render(){
    point(v.x, v.y);
  }

  void renderAuto(){
    float factor = 0.01;
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    point(v.x, v.y);
    strokeWeight((width+height)*0.5*factor*0.5);
    stroke(0);
    point(v.x, v.y);
  }

  void renderAuto(float factor){
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    point(v.x, v.y);
    strokeWeight((width+height)*0.5*factor*0.5);
    stroke(0);
    point(v.x, v.y);
  }
}





