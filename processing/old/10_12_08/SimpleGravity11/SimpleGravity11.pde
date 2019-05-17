ArrayList parts;

final float ATTRACTION = 0.01;
final float DETRACTION = 100;
final float DRAG = 0.90;

void setup(){

  size(500,500);
  frameRate(30);

  parts = new ArrayList();
  
  int num = 200;
  for(int i=0; i<num; i++) parts.add(new Part(randomPoint2Screen()));

}

void draw(){
  background(255);
  updateArrayLists();
}

void updateArrayLists(){
  for(int i=0; i<parts.size(); i++) ((Part) parts.get(i)).update();
}

