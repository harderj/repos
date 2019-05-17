PVector pos, vel, acc, p1, p2, midth, zero, gravity;
float ballRadius, ballDiameter, drag, lineDrag;

void setup(){
  size(500,500);
  smooth();
  ellipseMode(CENTER);
  
  midth = new PVector(width*0.5, height*0.5);
  zero = new PVector(0, 0);
  gravity = new PVector(0, 0.3);
  drag = 1;
  lineDrag = 0.5;
  
  ballDiameter = 30;
  ballRadius = ballDiameter*0.5;
  
  pos = new PVector(midth.x, height*0.25);
  vel = new PVector(0.1, 4);
  acc = new PVector();
  
  p1 = new PVector(width*0.25, height*0.6);
  p2 = new PVector(width*0.75, height*0.8);
}

void draw(){
  background(0);
  dragLine();
  updateBall();
  drawLine();
  drawBall();
}

void updateBall(){
  collideLine();
  collideScreen();
  
  acc.add(gravity);
  vel.add(acc);
  vel.mult(drag);
  pos.add(vel);
  acc.mult(0);
}

void dragLine(){
  if(mousePressed){
    float tmpMinDist = 10;
    
    PVector tmpMouse = new PVector(mouseX, mouseY);
    PVector tmpDelta1 = new PVector(p1.x, p1.y);
    PVector tmpDelta2 = new PVector(p2.x, p2.y);
    tmpDelta1.sub(tmpMouse);
    tmpDelta2.sub(tmpMouse);
    
    PVector tmpVect = new PVector(tmpMouse.x, tmpMouse.y);
    if(tmpMinDist*tmpMinDist > tmpDelta1.x*tmpDelta1.x + tmpDelta1.y*tmpDelta1.y) p1.set(new PVector(mouseX, mouseY));
    if(tmpMinDist*tmpMinDist > tmpDelta2.x*tmpDelta2.x + tmpDelta2.y*tmpDelta2.y) p2.set(new PVector(mouseX, mouseY));
  }
}

void collideLine(){
  // line collision
  float tmpAngle = atan2(p1.y-p2.y, p1.x-p2.x);
  
  PVector tmp1 = rotateAround(p1, midth, -tmpAngle);
  PVector tmp2 = rotateAround(p2, midth, -tmpAngle);
  PVector tmpVel = rotateAround(vel, zero, -tmpAngle);
  PVector tmpPos = rotateAround(pos, midth, -tmpAngle);
  
  PVector[] tmpCorner = new PVector[4];
  tmpCorner[0] = rotateAround(zero, midth, -tmpAngle);
  tmpCorner[1] = rotateAround(new PVector(width, 0), midth, -tmpAngle);
  tmpCorner[2] = rotateAround(new PVector(width, height), midth, -tmpAngle);
  tmpCorner[3] = rotateAround(new PVector(0, height), midth, -tmpAngle);
  
  PVector tmpMax = new PVector(max(tmp1.x, tmp2.x), max(tmp1.y, tmp2.y));
  PVector tmpMin = new PVector(min(tmp1.x, tmp2.x), min(tmp1.y, tmp2.y));
  if(tmpPos.x < tmpMax.x && tmpPos.x > tmpMin.x && tmpPos.y > tmp1.y -ballRadius && tmpPos.y < tmp1.y +ballRadius ){
    noStroke();
    fill(255);
    ellipse(0,0,20,20);
    
    tmpVel.y *= -lineDrag;
    if(tmpPos.y > tmp1.y) tmpPos.y = tmp1.y +ballRadius;
    else tmpPos.y = tmp1.y -ballRadius;
  } else {
    /*
    if(tmpPos.x < tmpMax.x +ballRadius && tmpPos.x > tmpMin.x -ballRadius && tmpPos.y > tmp1.y -ballRadius && tmpPos.y < tmp1.y +ballRadius){
      
      float tmpAngleBetween;
      if(tmpPos.x > tmpMax.x){
        //tmpPos.x = tmpMax.x +ballRadius;
        tmpAngleBetween = atan2(tmpMax.y-tmpPos.y, tmpMax.x-tmpPos.x);
      }
      else{
        //tmpPos.x = tmpMin.x -ballRadius;
        tmpAngleBetween = atan2(tmpMin.y-tmpPos.y, tmpMin.x-tmpPos.x);
      }
      tmpVel.x = cos(tmpAngleBetween)*tmpVel.mag();
      tmpVel.y = sin(tmpAngleBetween)*tmpVel.mag();
      
      //tmpVel.mult(-1);
    }
    */
  }
  
  noStroke();
  fill(255, 0, 0, 100);
  ellipse(tmpPos.x, tmpPos.y, ballDiameter, ballDiameter);
  
  noFill();
  stroke(255, 0, 0, 100);
  line(tmp1.x, tmp1.y, tmp2.x, tmp2.y);
  
  quad(tmpCorner[0].x, tmpCorner[0].y, tmpCorner[1].x, tmpCorner[1].y, tmpCorner[2].x, tmpCorner[2].y, tmpCorner[3].x, tmpCorner[3].y);
  
  tmp1 = rotateAround(tmp1, midth, tmpAngle);
  tmp2 = rotateAround(tmp2, midth, tmpAngle);
  tmpVel = rotateAround(tmpVel, zero, tmpAngle);
  tmpPos = rotateAround(tmpPos, midth, tmpAngle);
  
  vel = tmpVel;
  pos = tmpPos;
  
}

void collideScreen(){
  // screen collision
  if(pos.x < ballDiameter*0.5 || pos.x > width - ballDiameter*0.5){
    pos.x = constrain(pos.x, ballDiameter*0.5, width - ballDiameter*0.5);
    vel.x *= -1;
  }
  
  if(pos.y < ballDiameter*0.5 || pos.y > height - ballDiameter*0.5){
    pos.y = constrain(pos.y, ballDiameter*0.5, height - ballDiameter*0.5);
    vel.y *= -1;
  }
}

void drawBall(){
  noStroke();
  fill(255,100);
  ellipse(pos.x, pos.y, ballDiameter, ballDiameter);
}

void drawLine(){
  stroke(255, 100);
  strokeWeight(5);
  line(p1.x, p1.y, p2.x, p2.y);
}

PVector rotateAround(PVector vector, PVector around, float angle){
  PVector tmp = new PVector(vector.x, vector.y);
  tmp.sub(around);
  float tmpMagnitude = tmp.mag();
  float tmpAngle = atan2(tmp.y, tmp.x);
  tmp.set(around.x + cos(tmpAngle+angle)*tmpMagnitude, around.y + sin(tmpAngle+angle)*tmpMagnitude, 0);
  
  return tmp;
}

PVector setRotationAround(PVector vector, PVector around, float angle){
  PVector tmp = new PVector(vector.x, vector.y);
  tmp.sub(around);
  float tmpMagnitude = tmp.mag();
  tmp.set(around.x + cos(angle)*tmpMagnitude, around.y + sin(angle)*tmpMagnitude, 0);
  
  return tmp;
}
