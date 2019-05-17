class Line2{
  Vect2 v1, v2;

  Line2(Vect2 v1, Vect2 v2){
    this.v1 = v1;
    this.v2 = v2;
  }

  void set(Vect2 v1, Vect2 v2){
    this.v1 = v1;
    this.v2 = v2;
  }

  void add(Vect2 v){
    v1.add(v);
    v2.add(v);
  }

  void sub(Vect2 v){
    v1.subtract(v);
    v2.subtract(v);
  }

  void render(){
    line(v1.x, v1.y, v2.x, v2.y);
  }

  void renderAuto(){
    float factor = 0.01;
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    line(v1.x, v1.y, v2.x, v2.y);
    strokeWeight((width+height)*0.5*factor*0.5);
    stroke(0);
    line(v1.x, v1.y, v2.x, v2.y);
  }

  void renderAuto(float factor){
    strokeWeight((width+height)*0.5*factor);
    stroke(255);
    line(v1.x, v1.y, v2.x, v2.y);
    strokeWeight((width+height)*0.5*factor*0.5);
    stroke(0);
    line(v1.x, v1.y, v2.x, v2.y);
  }

  float tilt(){
    return (v1.y-v2.y)/(v1.x-v2.x);
  }

  float offset(){
    return v1.y-(v1.x*tilt());
  }

  boolean intersecting(Line2 l){
    Vect2 inter = lineIntersection(v1, v2, l.v1, l.v2);

    if(insideRect(inter, v1, v2) && insideRect(inter, l.v1, l.v2)) return true;
    else return false;
  }

  Vect2 intersection(Line2 l){
    Vect2 result = new Vect2();

    float a1 = tilt();
    float b1 = offset();
    float a2 = l.tilt();
    float b2 = l.offset();

    result.x = -1*((b1-b2)/(a1-a2));
    result.y = a1*result.x+b1;

    return result;
  }
}

