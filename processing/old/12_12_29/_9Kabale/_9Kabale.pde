int[][] game;
PImage backGround;
PImage[] face = new PImage[53];
int faceW, faceH;
PVector[] card = new PVector[106];

void setup(){
  size(1000,750);
  setupCards();
  backGround = loadImage("table.JPG");
  face[0] = loadImage("back.JPG");
  for(int i=1; i<53; i++) face[i] = loadImage(str(i) + ".jpg");
  faceW = 75;
  faceH = 100;
}

void draw(){
  background(backGround);
  drawFaces();
}

void drawFaces(){
  float w = 80; // space between columns
  float h = 110; // space between rows
  float ox = 50; // space to sides
  float oy = 50; // space to top
  for(int i=1; i<53; i++){
    int n = i-1;
    float x = ox+(w*n)%(width-faceW-ox*2);
    float y = oy+(int(w*n)/int(width-faceW-ox*2))*h;
    image(face[i], x, y);
  }
}

void setupCards(){
  
}
