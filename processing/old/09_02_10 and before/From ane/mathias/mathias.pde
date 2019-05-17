float x = 0;
float y = 0;
float xSpeed = 0;
float ySpeed = 0;


void setup(){
  
  size(500,500);
  background(0);
  frameRate(25);
  
}

void draw(){
  fade();
  
  float tmpAngle = atan2(y-mouseY, x-mouseX);
  float tmpDistance = dist(x,y,mouseX,mouseY);
  
  xSpeed -= cos(tmpAngle)*tmpDistance*(1/frameRate);
  ySpeed -= sin(tmpAngle)*tmpDistance*(1/frameRate);
  
  xSpeed *= 0.65;
  ySpeed *= 0.65;
  
  x += xSpeed;
  y += ySpeed;
  
  noStroke();
  fill(255,0,0);
  ellipse(x,y,20,20);
}

void fade(){
  noStroke();
  fill(0,20);
  rect(-1,-1,width+2,height+2);
}
