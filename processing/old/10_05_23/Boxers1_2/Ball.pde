class Ball{
  
  PVector p, v, a;
  float s;
  
  boolean hitFrame;
  
  Ball(float x, float y){
    
    p = new PVector(x, y);
    v = new PVector();
    a = new PVector();
    
    s = 10;
    
  }
  
  Ball(){
    
    p = new PVector(width*0.5, height*0.5);
    v = new PVector();
    a = new PVector();
    
    s = 10;
    
  }
  
  void update(){
    a.y += gravity;
    v.add(a);
    a.x = 0;
    a.y = 0;
    p.add(v);
  }
  
  void render(){
    fill(0,50);
    noStroke();
    ellipse(p.x, p.y, s, s);
  }
}
