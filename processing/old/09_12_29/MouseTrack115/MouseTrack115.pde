ArrayList stones, blocks;

PVector pos, vel, acc;
float drag = 0.99;

void setup(){
  size(500,500);
  smooth();
  frameRate(50);
  ellipseMode(CENTER);

  stones = new ArrayList();
  blocks = new ArrayList();

  stones.add(new Stone(new PVector(0.0, 0.0)));
  blocks.add(new Block(new PVector(random(width)-width*0.5, random(height)-height*0.5), 50));

  pos = new PVector(0,0);
  vel = new PVector(0,0);
  acc = new PVector(0,0);
}

void draw(){
  background(255);
  translate(width*0.5, height*0.5);
  
  updateLists();
}

void keyPressed(){
  if(key == 's') stones.add(new Stone(new PVector(0.0, 0.0)));
  if(key == 'b') blocks.add(new Block(new PVector(mouseX-width*0.5, mouseY-height*0.5), 50));
}

void updateLists(){
  for(int i=0; i<stones.size(); i++){
    if(((Stone) stones.get(i)).is){
      ((Stone) stones.get(i)).mouseAttractNormal();
      ((Stone) stones.get(i)).draw();
    }
    else {
      stones.remove(i);
    }
  }
  
  for(int i=0; i<blocks.size(); i++){
    if(((Block) blocks.get(i)).is){
      ((Block) blocks.get(i)).draw();
    }
    else {
      blocks.remove(i);
    }
  }
  
  for(int i=0; i<stones.size(); i++){
    ((Stone) stones.get(i)).render();
  }
}
