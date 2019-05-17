int pairCount = 5; //max 11 - min 1
pairCount = constrain(pairCount, 1, 11);

float brickLength = 50;

int brickNumX = 1;
int brickNumY = 0;

for(int i = 0; i < pairCount; i++){
  if(brickNumX>brickNumY && (brickY+1)*brickX < pairCount*2 && valueType(pairCount*4/((brickY+1)*brickX),'z')){
    brickNumY ++;
  }
  if(brickNumY>brickNumX && (brickX+1)*brickY < pairCount*2 && valueType(pairCount*4/((brickX+1)*brickY),'z')){
    brickNumX ++;
  }
}

ArrayList bricks;

PImage[] picList = new PImage[pairCount];

void setup(){
  size((brickNumX+1)*brickLength,(brickNumX+1)*brickLength);
  bricks = new ArrayList();


  for(int i = 0; i < pairCount*2; i++){
    if(valueType(i, 'e')) picList[i] = loadImage((i/2) + ".tif");
    int tmpX, tmpY;
    boolean tmpFlag = true;
    while(tmpFlag){
      tmpX = round(random(0,brickNumX));
      tmpY = round(random(0,brickNumX));
      
      int j = 0;
      while(j<bricks.size){
        if(j != i && tmpX != ((Brick) bricks.get(i)).x && tmpY != ((Brick) bricks.get(i)).y) tmpFlag = false;
        else tmpFlag true;
        j ++;
      }
    }
    bricks.add();
  }
  /*
  float tmpX = width/(brickNumX+2);
   float tmpY = height/(brickNumY+2);
   for(int i = 0; i < brickNumX; i++){
   for(int j = 0; j < brickNumY; j++){
   bricks.add(new Brick(tmpX*(i+1),tmpY*(j+1),idList[((i+1)*(j+1))-1]));
   }
   }
   */
}

void draw(){
  background(0);
  updateArrays();
}

void updateArrays(){
  for(int i = 0; i < bricks.size(); i++){
    if(((Brick) bricks.get(i)).active) ((Brick) bricks.get(i)).draw(); 
    else bricks.remove(i);
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

boolean valueType(float value, char type){
  boolean reflection = false;
  switch(type){
  case 'z':
    if(round(value) == value) reflection = true;
    break;

  case 'e':
    if(round(value*0.5) == value*0.5) reflection = true;
    break;

  case 'o':
    if(round((value-1)*0.5) == (value-1)*0.5) reflection = true;
    break;
  }

  return reflection;
}

