class Ball{
  
  PVector p, v, a;
  float s;
  
  boolean hittingFrame;
  boolean rendering;
  
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
    v.mult(drag);
    
    if(hittingFrame) hitFrame();
    
    if(rendering) render();
  }
  
  void render(){
    fill(0,50);
    noStroke();
    ellipse(p.x, p.y, s, s);
  }
  
  void hitFrame(){
    if(!insideScreen(p.x, p.y)){
      if(!insideInterval(p.x, 0, width)) v.x *= -1;
      if(!insideInterval(p.y, 0, height)) v.y *= -1;
      p.x = constrain(p.x, 0, width);
      p.y = constrain(p.y, 0, height);
    }
  }
}
