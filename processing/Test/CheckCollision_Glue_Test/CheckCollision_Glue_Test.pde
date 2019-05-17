PVector b, m, rl1, rl2;
float rB, rM;

void setup(){
  size(500,500);
  smooth();
  ellipseMode(CENTER);
  
  b = new PVector(width*0.5, height*0.5, 0.0);
  m = new PVector();
  rl1 = new PVector(random(width), random(height), 0.0);
  rl2 = new PVector(random(width), random(height), 0.0);
  rB = 50;
  rM = 10;
}

void draw(){
  background(255);
  m.set(mouseX, mouseY, 0.0);
  
  noStroke();
  if(checkCollision(b, m, rM, rB)) fill(125, 100);
  else fill(0, 100);
  ellipse(b.x, b.y, rB*2, rB*2);
  
  noStroke();
  fill(0,255,0,100);
  ellipse(m.x, m.y, rM*2, rM*2);
  
  if(checkCollision(b, m, rM, rB)){
    PVector tmpM = new PVector();
    PVector tmpC = new PVector();
    PVector tmpL = new PVector();
    
    tmpC.set(keepCirclesGlued(m, b, rM, rB));
    tmpM.set(mouseX-pmouseX, mouseY-pmouseY, 0.0);
    tmpL.set(calcVelCircleCollision(m, b, tmpM));
    
    noStroke();
    fill(255,0,0, 100);
    ellipse(tmpC.x, tmpC.y, rM*2, rM*2);
    
    stroke(0,100);
    strokeWeight(3);
    float f = 10;
    line(b.x + tmpL.x*f, b.y + tmpL.y*f, b.x, b.y);
  }
  
  PVector tmpI = new PVector();
  tmpI.set(intersect(new PVector(0,0), m, rl1, rl2));
  
  noFill();
  strokeWeight(3);
  stroke(125,0,125, 100);
  line(0,0, m.x, m.y);
  stroke(125,125,0, 100);
  line(rl1.x, rl1.y, rl2.x, rl2.y);
  stroke(0,0,0,100);
  ellipse(tmpI.x, tmpI.y, 10, 10);
  
  tmpI.set(intersect(m, new PVector(0,0), b, rB));
  ellipse(tmpI.x, tmpI.y, 10, 10);
}
