class Ray{
  boolean act = true;

  float x,y,a;
  float c = color(255,255,255);

  Ray(float x, float y, float angle){
    this.x = x;
    this.y = y;
    a = angle;
  }

  void draw(){
    update();
    out();
    render();
  }
  
  void update(){
    x += cos(a)*15;
    y += sin(a)*15;
  }
  
  void out(){
    if(x < 0 || y < 0 || x > width || y > height){
      act = false;
    }
  }
  
  void render(){
    stroke(255,20);
    strokeWeight(10);
    line(x,y,x-cos(a)*10,y-sin(a)*10);
  }
}
