boolean[][] pix;

void setup(){
  size(300, 300);
  
  pix = new boolean[width][height];
  
  for( int i = 0; i < width; i++ ){
    for( int j = 0; j < height; j++ ){
      if(random(2)<1) pix[i][j] = true;
      else pix[i][j] = false;
    }
  }
}

void draw(){
  background(125);
  if(pix[mouseX][mouseY]) fill(255);
  else fill(0);
  noStroke();
  ellipse(mouseX, mouseY, 10, 10);
}
