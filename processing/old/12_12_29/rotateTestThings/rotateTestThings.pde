
void setup(){
  size(500,500);
}

void draw(){
  background(255);
  
  float x = 50;
  float y = 40;
  if(mousePressed){
    float tmpMouseLength = sqrt(mouseX*mouseX + mouseY*mouseY);
    x /= mouseX / tmpMouseLength;
    y /= mouseY / tmpMouseLength;
  }
  noStroke();
  fill(0);
  ellipse(x,y,20,20);
  
}
