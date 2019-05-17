import processing.opengl.*;

ArrayList balls;

Point2 GRAVITY = new Point2(0.0,0.1);
float DRAG = 1;

void setup(){
  size(500,500,OPENGL);
  smooth();
  
  balls = new ArrayList();
  
  balls.add(new Ball(randomPoint2Screen(), 10));
  ((Ball) balls.get(0)).a.x += 1;
}

void draw(){
  background(255);
  updateArrays();
}

void mousePressed(){
  balls.add(new Ball(randomPoint2Screen(), 25));
}

void updateArrays(){
  for(int i=0; i<balls.size(); i++){
    if(((Ball) balls.get(i)).is) ((Ball) balls.get(i)).update();
    else balls.remove(i);
  }
}
