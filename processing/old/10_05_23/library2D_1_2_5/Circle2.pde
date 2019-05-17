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
