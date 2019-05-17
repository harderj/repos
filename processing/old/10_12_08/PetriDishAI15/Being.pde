class Being{
  
  Phys2 b; // rigid-B-ody
  Point2 s1, s2;
  ArrayList memory;
  
  Being(Point2 pos){
    memory = new ArrayList();
    b = new Phys2(pos);
    s1 = new Point2();
    s2 = new Point2();
  }
  
  void update(){
    remember();
    
    move();
    render();
  }
  
  void move(){
    b.update();
    s1.x = cos(b.r+0.5*BEING_SENS_ANGLE)*b.m;
    s1.x = cos(b.r+0.5*BEING_SENS_ANGLE)*b.m;
    s2.y = sin(b.r-0.5*BEING_SENS_ANGLE)*b.m;
    s2.y = sin(b.r-0.5*BEING_SENS_ANGLE)*b.m;
  }
  
  void remember(){ // doen't work with multiple foods yet
    float sens1 = calcSens(s1);
    float sens2 = calcSens(s2);
    memory.add( new Memo(sens1, sens2) );
  }
  
  void render(){
    noStroke();
    fill(255,200);
    ellipse(b.p.x, b.p.y, b.m*2, b.m*2);
  }
}

class Memo{
  float s1, s2;
  boolean m1, m2, f;
  
  Memo(float sens1, float sens2){
    s1 = sens1;
    s2 = sens2;
    m1 = false;
    m2 = false;
    f = false;
  }
}

float calcSens(Point2 poi){
  Point2 delta = poi.copy();
  delta.subtract(f1);
  delta.scale(BEING_SENS_FACTOR);
  
  return 1/((delta.x*delta.x + delta.y*delta.y)+1);
}
