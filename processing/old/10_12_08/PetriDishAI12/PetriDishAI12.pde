

void setup(){
  size(500,500);
}

void draw(){
  background(0);
}

class being{
  
  Phys2 rigid;
  ArrayList memory;
  
  being(Point2 pos){
    age = 0;
    memory = new ArrayList();
    rigid = new Phys2(pos);
  }
  
  void update(){
    
    rigid.update();
    render();
  }
  
  void render(){
    ellipse(
  }
}

class memo{
  float s1, s2;
  boolean m1, m2, f;
  
  memo(sens1, sens2, move1, move2, food){
    s1 = sens1;
    s2 = sens2;
    m1 = move1;
    m2 = move2;
    f = food;
  }
}
