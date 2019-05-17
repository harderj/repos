

void drawGrid() {
  stroke(0);
  for(int i=0; i<10; i++) {
    strokeWeight(1);
    if(i%3==0) strokeWeight(3);
    line((i+1)*width/11, height/11, (i+1)*width/11, 10*height/11);
    line(width/11, (i+1)*height/11, 10*width/11, (i+1)*height/11);
  }
}
