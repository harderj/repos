class Ball{
  boolean use = true;
  int id;

  Vect2 pos = new Vect2();
  Vect2 vel = new Vect2();
  Vect2 acc = new Vect2();
  float r, m;

  Ball(Vect2 pos, Vect2 vel, float r) {
    this.pos = pos;
    this.vel = vel;
    acc.setZero();
    this.r = r;
    m = r*.1;
  }

  void run(int id){
    this.id = id;
    updatePos();
    render();
    hitBalls();
    hitFrame();
  }

  void updatePos(){
    acc.add(gravity);
    
    vel.add(acc);
    
    vel.mult(airFriction,airFriction);
    
    pos.add(vel);
    
    acc.setZero();
  }

  void render(){
    noStroke();
    fill(0);
    ellipse(pos.x, pos.y, r*2, r*2);
  }

  void hitBalls(){
    for(int i=0; i<balls.size(); i++){
      Vect2 tmpPos = new Vect2(((Ball) balls.get(i)).pos);
      Vect2 tmpVel = new Vect2(((Ball) balls.get(i)).vel);
      Vect2 tmpAcc = new Vect2(((Ball) balls.get(i)).acc);
      float tmpM = ((Ball) balls.get(i)).m;
      float tmpR = ((Ball) balls.get(i)).r;
      float tmpID = ((Ball) balls.get(i)).id;
      float distance = dist(pos.x, pos.y, tmpPos.x, tmpPos.y);

      Vect2 bVect = new Vect2();
      bVect.x = tmpPos.x - pos.x;
      bVect.y = tmpPos.y - pos.y;
      float bVectMag = sqrt(bVect.x * bVect.x + bVect.y * bVect.y);

      if (bVectMag < r + tmpR && id != tmpID){
        float theta  = atan2(bVect.y, bVect.x);
        float sine = sin(theta);
        float cosine = cos(theta);

        Vect2[] tmpA = {  
          new Vect2(),
          new Vect2()
          };

        tmpA[1].x  = cosine * bVect.x + sine * bVect.y;
        tmpA[1].y  = cosine * bVect.y - sine * bVect.x;

        // rotate Temporary velocities
        Vect2[] tmpB = {
          new Vect2(), new Vect2()                    };
        tmpB[0].x  = cosine * vel.x + sine * vel.y;
        tmpB[0].y  = cosine * vel.y - sine * vel.x;
        tmpB[1].x  = cosine * tmpVel.x + sine * tmpVel.y;
        tmpB[1].y  = cosine * tmpVel.y - sine * tmpVel.x;

        Vect2[] tmpC = {
          new Vect2(), new Vect2()                    };
        // final rotated velocity for pos
        tmpC[0].x = ((m - tmpM) * tmpB[0].x + 2 * tmpM * tmpB[1].x) / (m + tmpM);
        tmpC[0].y = tmpB[0].y;
        // final rotated velocity for pos
        tmpC[1].x = ((tmpM - m) * tmpB[1].x + 2 * m * tmpB[0].x) / (m + tmpM);
        tmpC[1].y = tmpB[1].y;

        // hack to avoid clumping
        tmpA[0].x += tmpC[0].x;
        tmpA[1].x += tmpC[1].x;

        // rotate balls
        Vect2[] tmpD = {new Vect2(), new Vect2()};
        tmpD[0].x = cosine * tmpA[0].x - sine * tmpA[0].y;
        tmpD[0].y = cosine * tmpA[0].y + sine * tmpA[0].x;
        tmpD[1].x = cosine * tmpA[1].x - sine * tmpA[1].y;
        tmpD[1].y = cosine * tmpA[1].y + sine * tmpA[1].x;

        // update balls to screen position
        tmpPos.x = pos.x + tmpD[1].x;
        tmpPos.y = pos.y + tmpD[1].y;
        pos.x = pos.x + tmpD[0].x;
        pos.y = pos.y + tmpD[0].y;

        // update velocities
        vel.x = cosine * tmpC[0].x - sine * tmpC[0].y;
        vel.y = cosine * tmpC[0].y + sine * tmpC[0].x;
        tmpVel.x = cosine * tmpC[1].x - sine * tmpC[1].y;
        tmpVel.y = cosine * tmpC[1].y + sine * tmpC[1].x;
        
        ((Ball) balls.get(i)).pos.x = tmpPos.x;
        ((Ball) balls.get(i)).pos.y = tmpPos.y;
        ((Ball) balls.get(i)).vel.x = tmpVel.x;
        ((Ball) balls.get(i)).vel.y = tmpVel.y;
      }
    }
  }

  /*
  
   */

  void hitFrame(){
    if (pos.x > width-r){
      pos.x = width-r;
      vel.x *= -frameFriction[1];
      vel.y *= frameFriction[1];
    }
    if (pos.y > height-r){
      pos.y = height-r;
      vel.x *= frameFriction[1];
      vel.y *= -frameFriction[2];
    }
    if (pos.x < r){
      pos.x = r;
      vel.x *= -frameFriction[3];
      vel.y *= frameFriction[1];
    }
    if (pos.y < r){
      pos.y = r;
      vel.x *= frameFriction[1];
      vel.y *= -frameFriction[0];
    }
  }
}
