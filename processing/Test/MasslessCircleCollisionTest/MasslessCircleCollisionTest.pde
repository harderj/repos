PVector pos, vel, acc;
float mouseDiameter, ballDiameter;

void setup(){
  size(500,500);
  noCursor();
  smooth();
  ellipseMode(CENTER);
  
  mouseDiameter = 50;
  ballDiameter = 30;
  
  pos = new PVector(width*0.5, height*0.5);
  vel = new PVector();
  acc = new PVector();
}

void draw(){
  background(0);
  drawMouse();
  updateBall();
  drawBall();
}

void updateBall(){
  PVector mouse = new PVector(mouseX, mouseY);
  PVector delta = new PVector(pos.x, pos.y);
  delta.sub(mouse);
  float collisionDistance = (ballDiameter+mouseDiameter)*0.5;
  
  // mouse collision
  if(delta.x*delta.x + delta.y*delta.y < collisionDistance*collisionDistance){
    // set new posision
    float angle = atan2(delta.y, delta.x);
    PVector angleVector = new PVector(cos(angle), sin(angle));
    PVector newPos = new PVector(angleVector.x, angleVector.y);
    newPos.mult(collisionDistance*1.01);
    newPos.add(mouse);
    pos.set(newPos);
    
    /* set new acceleration
    PVector mouseVel = new PVector(mouse.x - pmouseX, mouse.y - pmouseY);
    PVector newAcc = new PVector(angleVector.x, angleVector.y);
    newAcc.mult(mouseVel.mag());
    acc.add(newAcc);
    */
    
    // set new velocity
    PVector mouseVel = new PVector(mouse.x - pmouseX, mouse.y - pmouseY);
    PVector newVel = new PVector(angleVector.x, angleVector.y);
    float mouseVelAngle = atan2(mouseVel.y, mouseVel.x);
    newVel.mult(mouseVel.mag());
    newVel.mult(sin(angle-mouseVelAngle));
    vel.set(newVel);
  }
  
  // screen collision
  if(pos.x < ballDiameter*0.5 || pos.x > width - ballDiameter*0.5){
    pos.x = constrain(pos.x, ballDiameter*0.5, width - ballDiameter*0.5);
    vel.x *= -1;
  }
  
  if(pos.y < ballDiameter*0.5 || pos.y > height - ballDiameter*0.5){
    pos.y = constrain(pos.y, ballDiameter*0.5, height - ballDiameter*0.5);
    vel.y *= -1;
  }
  
  vel.add(acc);
  pos.add(vel);
  acc.mult(0);
}

void drawBall(){
  noStroke();
  fill(255,100);
  ellipse(pos.x, pos.y, ballDiameter, ballDiameter);
}

void drawMouse(){
  noStroke();
  fill(255,100);
  ellipse(mouseX, mouseY, mouseDiameter, mouseDiameter);
}
