class Circle2{ // not tested
  
  // BASE VARIABLES
  
  Vect2 p;
  float r;
  
  // CONSTRUCTORS
  
  Circle2(Vect2 position, float radius){
    p = position;
    r = radius;
  }
  
  // SETTING WITH INPUT
  
  // SETTING WITHOUT INPUT
  
  // RETURNING WITH INPUT
  
  boolean intersectingCircle(Circle2 c){ //not tested
    return insideCircle(p, c.p, r+c.r);
  }
  
  // RETURNING WITHOUT INPUT
  
  // NEITHER RETURNING NOR SETTING
  
  void render(){
    ellipse(p.x, p.y, r*2, r*2);
  }
  
  void renderAuto(){ // not tested
    float factor = 0.01;
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    fill(0);
    ellipse(p.x, p.y, r*2, r*2);
  }
  
  void renderAuto(float factor){ // not tested
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    fill(0);
    ellipse(p.x, p.y, r*2, r*2);
  }
}