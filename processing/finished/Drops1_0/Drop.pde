class Drop{
  boolean is = true;
  float x, y, s;
  
  
  Drop(float x, float y, float s){
    this.x = x;
    this.y = y;
    this.s = s;
  }
  
  void draw(int arrayNum){
    move();
    if(is) collide(arrayNum);
    basicRules();
    render();
  }
  
  void collide(int tmpN){
    int i = (tmpN+2)%drops.size();
    while(i != inbound(tmpN-1,0,drops.size())){
      i = (i+1)%drops.size();
      float tmpX = ((Drop) drops.get(i)).x;
      float tmpY = ((Drop) drops.get(i)).y;
      float tmpS = ((Drop) drops.get(i)).s;
      boolean tmpIs = ((Drop) drops.get(i)).is;
      if(dist(x,y,tmpX,tmpY) < (s*bindingDistFactor) + (tmpS*bindingDistFactor) && tmpIs){
        float tmpAngle = atan2(y -tmpY, x -tmpX);
        float tmpMove = s/(s+tmpS);
        
        x += cos(tmpAngle)*tmpMove;
        y += sin(tmpAngle)*tmpMove;
        s += sqrt(tmpS);
        
        ((Drop) drops.get(i)).is = false;
      }
    }
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
