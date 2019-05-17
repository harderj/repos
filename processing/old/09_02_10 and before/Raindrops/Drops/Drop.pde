class Drop{
  boolean is = true;
  float x, y, s;
  
  
  Drop(float x, float y, float s){
    this.x = x;
    this.y = y;
    this.s = s*globalScale;
  }
  
  void draw(){
    move();
    collide();
    basicRules();
    render();
  }
  
  void collide(){
    
  }
  
  void basicRules(){
    if(x<0 || y<0 || x>width || y>height) is = false;
  }
  
  
  void move(){
    if(s>bindingLimit){
      y += speedBace*speedSizeFactor*(s - bindingLimit);
    }
  }
  
  void render(){
    noStroke();
    fill(255);
    ellipse(x,y,s,s);
  }
}
