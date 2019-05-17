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

