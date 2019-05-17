class Area{
  boolean act = true;
  
  int timer = 0;
  float x,y;
  color col = color(255);
  String mode = "none";
  
  boolean renderFlag = false;

  Area(int x, int y){
    this.x = float(x);
    this.y = float(y);
  }
  
  void draw(){
    if(timer > 0) timer --;
    if(renderFlag) render();
  }

  void update(){
  }

  void render(){
    float tmpX = x * GWP;
    float tmpY = y * GHP;
    
    fill(col);
    noStroke();
    rect(tmpX,tmpY,GWP,GHP);
  }
}
