class Astroid{
  boolean is = true;

  Vect2 pos, vel, acc;
  float direction, vol, angVel;

  int pointCount;
  Vect2[] points;

  Astroid(Vect2 posision, Vect2 velocity, float volume){
    pos = new Vect2(posision);
    vel = new Vect2(velocity);
    acc = new Vect2();
    vol = volume;
    angVel = random(-astroidSpin, astroidSpin);
    direction = random(TWO_PI);

    pointCount = int(random(astroidPointCount-astroidPointCountDiversity, astroidPointCount+astroidPointCountDiversity));
    points = new Vect2[pointCount];
    float randomSizeFactor = randomPointFactorAstroid;
    float tmpMin = volume*(1-randomSizeFactor);
    float tmpMax = volume/(1-randomSizeFactor);
    for(int i=0; i<pointCount; i++) {
      float tmpX = cos((TWO_PI/pointCount)*i)*random(tmpMin, tmpMax);
      float tmpY = sin((TWO_PI/pointCount)*i)*random(tmpMin, tmpMax);
      points[i] = new Vect2( tmpX, tmpY );
    }
  }

  void draw(){
    updateBaseValues();
    render();
  }

  void updateBaseValues(){
    vel.add(acc);
    pos.add(vel);
    acc.set();

    direction += angVel;

    
    Vect2 tmpPos = new Vect2(pos);
    tmpPos.sub(width*0.5, height*0.5);
    float tmpDist = tmpPos.x * tmpPos.x + tmpPos.y * tmpPos.y;
    if(tmpDist > astroidCreationDist*astroidCreationDist){
      is = false;
    }
    
    //if(pos.x < -vol || pos.y < -vol || pos.x > width + vol || pos.y > height + vol) is = false;
  }

  void render(){
    fill(140,90,40);
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(direction);
    beginShape();
    for(int i=0; i<pointCount; i++){
      vertex( points[i].x, points[i].y );
    }
    endShape();
    popMatrix();
  }
}
