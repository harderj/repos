ArrayList stones, blocks;

boolean checkMode = false;
float drag = 0.99;

void setup(){
  size(500,500);
  smooth();
  frameRate(35);
  ellipseMode(CENTER);

  stones = new ArrayList();
  blocks = new ArrayList();

  stones.add(new Stone(new PVector(0.0, 0.0)));
  blocks.add(new Block(new PVector(random(width)-width*0.5, random(height)-height*0.5), 50));
}

void draw(){
  background(255);
  translate(width*0.5, height*0.5);
  
  updateLists();
}

void keyPressed(){
  if(key == 's') stones.add(new Stone(new PVector(0.0, 0.0)));
  if(key == 'e') blocks.add(new Block(new PVector(mouseX-width*0.5, mouseY-height*0.5), 50));
  if(key == 'l') blocks.add(new Block(new PVector(random(width)-width*0.5, random(height)-height*0.5), new PVector(random(width)-width*0.5, random(height)-height*0.5)));
  if(key == 'd'){
    for(int i=0; i<stones.size(); i++){
      float tR = ((Stone) stones.get(i)).r;
      PVector tPos = new PVector(((Stone) stones.get(i)).pos.x, ((Stone) stones.get(i)).pos.y);
      PVector tM = new PVector(mouseX-width*0.5, mouseY-height*0.5);
      if((tPos.x-tM.x)*(tPos.x-tM.x)+(tPos.y-tM.y)*(tPos.y-tM.y) < tR*tR){
        stones.remove(i);
      }
    }
    
    for(int i=0; i<blocks.size(); i++){
      float tR = ((Block) blocks.get(i)).r;
      PVector tPos = new PVector(((Block) blocks.get(i)).pos.x, ((Block) blocks.get(i)).pos.y);
      PVector tM = new PVector(mouseX-width*0.5, mouseY-height*0.5);
      if((tPos.x-tM.x)*(tPos.x-tM.x)+(tPos.y-tM.y)*(tPos.y-tM.y) < tR*tR){
        blocks.remove(i);
      }
    }
  }
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
