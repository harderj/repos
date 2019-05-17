class Brick{
  boolean active = true;

  boolean shown = false;
  int x, y;

  Brick(float x, float y){
    this.x = x;
    this.y = y;
  }

  void draw(){
    render();
  }

  void render(){
    if(shown){
      fill(255);
      ellipse(x,y,vol/2,vol/2);
    } 
    else {
      noStroke();
      fill(127);
      ellipse(x,y,vol,vol);
    }
  }
}

