class Brick{
  boolean active = true;
  
  boolean shown = false;
  float x, y, vol;
  String id;
  
  Brick(float x, float y, String id){
    this.x = x;
    this.y = y;
    this.id = id;
    vol = 50;
  }
  
  void draw(){
    render();
  }
  
  void render(){
    fill(127);
    ellipse(x,y,vol,vol);
    
    if(shown){
      fill(50);
      ellipse(x,y,vol/2,vol/2);
    }
  }
}
