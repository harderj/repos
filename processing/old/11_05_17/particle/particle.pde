import processing.opengl.*;

ArrayList parts;

final float ATTRACTION = 0.01;
final float DETRACTION = 10;
final float DRAG = 0.5;

void setup(){

  size(700,700, OPENGL);
  smooth();

  parts = new ArrayList();
  
  int num = 300;
  for(int i=0; i<num; i++) parts.add(new Part(randomPoint2Screen()));

}

void draw(){
  background(255);
  updateArrayLists();
  println(frameRate);
}

void updateArrayLists(){
  for(int i=0; i<parts.size(); i++) ((Part) parts.get(i)).update();
}
