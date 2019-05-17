float astroidSpin = TWO_PI*0.05;
float astroidPointCount = 8;
float astroidPointCountDiversity = 2;
float astroidPointDistDiversity = 0.7;

class Astroid{
  boolean is = true;

  PVector pos, vel;
  float direction, vol, angVel;

  int pointCount;
  PVector[] points;

  Astroid(PVector posision, PVector velocity, float volume){
    pos = new PVector(posision.x, posision.y);
    vel = new PVector(velocity.x, velocity.y);
    vol = volume;
    angVel = random(-astroidSpin, astroidSpin);
    direction = random(TWO_PI);

    pointCount = int(random(astroidPointCount-astroidPointCountDiversity, astroidPointCount+astroidPointCountDiversity));
    points = new PVector[pointCount];
    float randomSizeFactor = astroidPointDistDiversity;
    float tmpMin = volume*(randomSizeFactor);
    float tmpMax = volume/(randomSizeFactor);
    for(int i=0; i<pointCount; i++) {
      float tmpX = cos((TWO_PI/pointCount)*i)*random(tmpMin, tmpMax);
      float tmpY = sin((TWO_PI/pointCount)*i)*random(tmpMin, tmpMax);
      points[i] = new PVector( tmpX, tmpY );
    }
  }

  void update(){
    updateBaseValues();
    render();
  }

  void updateBaseValues(){
    vel.mult(drag);
    pos.add(vel);
    
    angVel *= angularDrag;
    direction += angVel;

    /*
    PVector tmpPos = new PVector(pos.x, pos.y);
    tmpPos.sub(width*0.5, height*0.5);
    float tmpDist = tmpPos.x * tmpPos.x + tmpPos.y * tmpPos.y;
    if(tmpDist > astroidCreationDist*astroidCreationDist){
      is = false;
    }
    
    //if(pos.x < -vol || pos.y < -vol || pos.x > width + vol || pos.y > height + vol) is = false;
    */
  }

  void render(){
    fill(140,90,40);
    noStroke();
    PVector relativePos = relate(pos);
    ellipse(relativePos.x, relativePos.y, 30, 30);
    
    /*
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(direction);
    beginShape();
    for(int i=0; i<pointCount; i++){
      vertex( points[i].x, points[i].y );
    }
    endShape();
    popMatrix();
    */
  }
}
