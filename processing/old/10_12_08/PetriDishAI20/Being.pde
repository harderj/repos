class Being{
  
  Phys2 b; // rigid-B-ody
  Point2 s1, s2; // sensor 1 & 2
  Point2 l1, l2; // leg 1 & 2
  ArrayList memory;
  
  // vars for primitive AI
  
  int primitiveStep = 0;
  
  Being(Point2 pos){
    memory = new ArrayList();
    b = new Phys2(pos);
    s1 = new Point2();
    s2 = new Point2();
    l1 = new Point2();
    l2 = new Point2();
  }
  
  void update(){
    remember();
    AI();
    baseVars();
    render();
  }
  
  void useLeg(boolean which){
    float ang;
    if(which) ang = 0.5*BEING_LEGS_ANGLE;
    else ang = -0.5*BEING_LEGS_ANGLE;
    
    b.a.x += cos(PI-ang + b.r)*BEING_SPEED;
    b.a.y += sin(PI-ang + b.r)*BEING_SPEED;
    
    if(which) b.rv += BEING_ROTATIONAL_SPEED;
    else b.rv -= BEING_ROTATIONAL_SPEED;
  }
  
  void baseVars(){
    // physic update (pos, vel, acc)
    b.update();
    
    // sensors
    s1.x = b.p.x+cos(b.r+0.5*BEING_SENS_ANGLE)*b.m;
    s1.y = b.p.y+sin(b.r+0.5*BEING_SENS_ANGLE)*b.m;
    s2.x = b.p.x+cos(b.r-0.5*BEING_SENS_ANGLE)*b.m;
    s2.y = b.p.y+sin(b.r-0.5*BEING_SENS_ANGLE)*b.m;
    
    //legs
    l1.x = b.p.x+cos(b.r+0.5*BEING_LEGS_ANGLE)*b.m;
    l1.y = b.p.y+sin(b.r+0.5*BEING_LEGS_ANGLE)*b.m;
    l2.x = b.p.x+cos(b.r-0.5*BEING_LEGS_ANGLE)*b.m;
    l2.y = b.p.y+sin(b.r-0.5*BEING_LEGS_ANGLE)*b.m;
  }
  
  void remember(){ // doen't work with multiple foods yet
    float sens1 = calcSens(s1);
    float sens2 = calcSens(s2);
    memory.add( new Memo(sens1, sens2) );
  }
  
  void render(){
    //body
    noStroke();
    fill(255,200);
    ellipse(b.p.x, b.p.y, b.m*2, b.m*2);
    
    //sensors
    fill(0,200);
    strokeWeight(2);
    stroke(0,150,255,200);
    ellipse(s1.x, s1.y, b.m*2*BEING_SENS_RADIUS_FACTOR, b.m*2*BEING_SENS_RADIUS_FACTOR);
    ellipse(s2.x, s2.y, b.m*2*BEING_SENS_RADIUS_FACTOR, b.m*2*BEING_SENS_RADIUS_FACTOR);
    
    //legs
    Point2 tmpL1 = l1.copy();
    Point2 tmpL2 = l2.copy();
    tmpL1.x += cos(b.r+0.5*BEING_LEGS_ANGLE);
    tmpL1.y += sin(b.r+0.5*BEING_LEGS_ANGLE);
    tmpL2.x += cos(b.r-0.5*BEING_LEGS_ANGLE);
    tmpL2.y += sin(b.r-0.5*BEING_LEGS_ANGLE);
    noFill();
    strokeWeight(4);
    stroke(255,200);
    line(l1.x, l1.y, tmpL1.x, tmpL1.y);
    line(l2.x, l2.y, tmpL2.x, tmpL2.y);
  }
  
  void AI(){
    primitive(); // first made AI-method, which is not really AI, but rather the thing the AI ultimately should be doing
  }
  
  void primitive(){
    float sens1 = ((Memo) memory.get(memory.size()-1)).s1;
    float sens2 = ((Memo) memory.get(memory.size()-1)).s2;
    
    if(primitiveStep == 0){
      if( sens1 < sens2) useLeg(false);
      else useLeg(true);
      primitiveStep ++;
    }
    
    if(primitiveStep == 1){
      if(random(1)<0.01) primitiveStep = 0;
    }
    
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
