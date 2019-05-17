class Poly2{

  // BASE VARIABLES

  Vect2[] p;

  // CONSTRUCTORS

  Poly2(int length){
    p = new Vect2[length];
  }

  Poly2(Vect2[] points){
    p = points;
  }

  // SETTING WITH INPUT
  
  void transpose(Vect2 v){
    for(int i=0; i<p.length; i++) p[i].add(v);
  }
  
  void scale(float a){
    for(int i=0; i<p.length; i++) p[i].scale(a);
  }
  
  void divide(float a){
    for(int i=0; i<p.length; i++) p[i].divide(a);
  }
  
  void rotateAroundAveragePosition(float a){
    for(int i=0; i<p.length; i++) p[i] = setRotationAround(p[i], averagePosition(), a);
  }
  
  // SETTING WITHOUT INPUT

  void setRandomScreen(){
    for(int i=0; i<p.length; i++) p[i] = randomVect2Screen();
  }

  // RETURNING WITH INPUT

  boolean containPoint(Vect2 v){
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

  // RETURNING WITHOUT INPUT

  boolean selfIntersecting(){

    // NOTE - does always not work if:
    // - two or more vertices has exactly the same positions/Vect2-values

    Line2[] l = new Line2[p.length];
    for(int i=0; i<p.length; i++){
      l[i] = new Line2(p[i], p[(i+1)%p.length]);
    }

    if(intersectingMultipleLines(l)) return true;
    else return false;
  }

  Vect2 averagePosition(){
    Vect2 a = new Vect2();
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

