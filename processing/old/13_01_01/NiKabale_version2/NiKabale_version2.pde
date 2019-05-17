int[][] game;
PImage tableTexture;
PImage[] face = new PImage[53];
int faceW, faceH;
PVector[] card = new PVector[106];

void setup(){
  size(1000,750);
  setupCards();
  tableTexture = loadImage("table.JPG");
  face[0] = loadImage("back.JPG");
  for(int i=1; i<53; i++) face[i] = loadImage(str(i) + ".jpg");
  faceW = 75;
  faceH = 100;
}

void draw(){
  background(tableTexture);
  drawFaces();
  drawFace(mouseX,mouseY,3);
}

void drawFace(int pile, int rank, int f){
  float x = pileX[pile];
  float y = pileY[rank];
  image(face[f], x, y);
}

void setupCards(){
  
}
