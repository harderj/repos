class Fire{
  boolean act = true;
  float x,y,xSpe,ySpe;
  int life;
  color col;
  
  Fire(float x, float y, float xSpe, float ySpe, int life, color col){
    this.x = x;
    this.y = y;
    this.xSpe = xSpe;
    this.ySpe = ySpe;
    this.life = life;
    this.col = col;
  }
  
  void draw(){
    life--;
    if(life < 0) act = false;
    
    ySpe += 0.2;
    x += xSpe;
    y += ySpe;
    
    noStroke();
    fill(col);
    ellipse(x,y,5,5);
  }
}
