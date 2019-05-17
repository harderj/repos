ArrayList stones;

PVector pos, vel, acc;
float drag = 1;

void setup(){
  size(500,500);
  smooth();
  frameRate(50);

  stones = new ArrayList();

  stones.add(new Stone(new PVector(0.0, 0.0)));

  pos = new PVector(0,0);
  vel = new PVector(0,0);
  acc = new PVector(0,0);
}

void draw(){
  background(255);
  translate(width*0.5, height*0.5);
  
  updateLists();
}

void updateLists(){
  for(int i=0; i<stones.size(); i++){
    if(((Stone) stones.get(i)).is){
      ((Stone) stones.get(i)).mouseAttractGravity();
      ((Stone) stones.get(i)).draw();
    }
    else {
      stones.remove(i);
    }
  }
}
