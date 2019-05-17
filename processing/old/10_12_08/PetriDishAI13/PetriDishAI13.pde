
Point2 MIDTH = new Point2(width*0.5, height*0.5);;
float BEING_RADIUS = 10;
float FOOD_RADIUS = 5;
float DRAG;

Being ani;
Point2 f1;

void setup(){
  size(500,500);
  smooth();
  
  f1 = randomPoint2Screen();
    
  ani = new Being(MIDTH);
  ani.b.m = BEING_RADIUS;
}

void draw(){
  background(0);
  
  renderFood();
  
  ani.update();
}

void renderFood(){
  noStroke();
  fill(0,255,0,200);
  ellipse(f1.x, f1.y, FOOD_RADIUS*2, FOOD_RADIUS*2);
}

class Being{
  
  Phys2 b; // rigid-B-ody
  Point2 s1, s2;
  ArrayList memory;
  
  Being(Point2 pos){
    memory = new ArrayList();
    b = new Phys2(pos);
  }
  
  void update(){
    remember();
    
    
    
    b.update();
    render();
  }
  
  void remember(){ // doen't work with multiple foods yet
    Point2
    sens1 = 1/(f1.x*f1.x )
    memory.add( new Memo(,2,false,false,false) );
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
  
  Memo(float sens1, float sens2, boolean move1, boolean move2, boolean food){
    s1 = sens1;
    s2 = sens2;
    m1 = move1;
    m2 = move2;
    f = food;
  }
}
