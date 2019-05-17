ArrayList bricks;

int pairCount = 5; //max 11 - min 1
pairCount = constrain(pairCount, 1, 11);
float brickLength = 50;

int brickNumX = 1;
int brickNumY = 0;

for(int i = 0; i < pairCount; i++){
  if(brickNumX>brickNumY && (brickY+1)*brickX < pairCount*2){
    brickNumY ++;
  }
  if(brickNumY>brickNumX && (brickX+1)*brickY < pairCount*2){
    brickNumX ++;
  }
}

String[] idList = new String[int(brickNumX*brickNumY)];

PImage[] pics

void setup(){
  size(500,500);
  bricks = new ArrayList();
  
  float tmpX = width/(brickNumX+2);
  float tmpY = height/(brickNumY+2);
  for(int i = 0; i < brickNumX; i++){
    for(int j = 0; j < brickNumY; j++){
      bricks.add(new Brick(tmpX*(i+1),tmpY*(j+1),idList[((i+1)*(j+1))-1]));
    }
  }
}

void draw(){
  background(0);
  updateArrays();
}

void updateArrays(){
  for(int i = 0; i < bricks.size(); i++){
    if(((Brick) bricks.get(i)).active) ((Brick) bricks.get(i)).draw(); else bricks.remove(i);
  }
}

void mousePressed(){
  for(int i = 0; i < bricks.size(); i++){
    float tmpDist = dist(mouseX,mouseY,((Brick) bricks.get(i)).x,((Brick) bricks.get(i)).y);
    if(tmpDist < 25){
      ((Brick) bricks.get(i)).shown = true;
    }
  }
}
