class Missile{
  boolean is = true;

  String name;
  Vect2 pos, vel, acc;
  float direction;
  float dmg = 1;
  float vol = 2.5;
  int birthday;

  Missile(String name, Vect2 posision, Vect2 velocity, float direction){
    this.name = name;
    pos = new Vect2(posision);
    vel = new Vect2(velocity);
    acc = new Vect2();
    this.direction = direction;

    birthday = frameCount;

    specialAbilities(0);
  }

  void draw(){
    specialAbilities(1);
    updateBaseValues();
    outOfScreen();
    render();
  }

  void updateBaseValues(){
    vel.add(acc);
    vel.mult(drag);
    pos.add(vel);
    acc.set();
  }

  void outOfScreen(){
    if(pos.x<0 || pos.y<0 || pos.x>width || pos.y>height){
      is = false;
      specialAbilities(2);
    }
  }

  void render(){
    //body
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, vol*2, vol*2);
  }

  void specialAbilities(int callMode){

    /* EMPTY DEFAULT
     // MISSILENAME
     if(name.equals("missilename")){
     // setup call
     if(callMode == 0){
     dmg = 1;
     }
     
     // draw call
     if(callMode == 1){
     // add acceleration first n frames
     float speed = 1;
     int fuelLimit = 100; // frames of burst
     if(frameCount-birthday < fuelLimit){
     acc.add(cos(direction)*speed, sin(direction)*speed);
     }
     
     // death due to low speed & age
     float minVelocity = 5;
     float maxAge = 100;
     if(vel.magnitude2() < pow(minVelocity,2) && frameCount-birthday > maxAge){
     is = false;
     specialAbilities(2);
     }
     }
     
     // death call
     if(callMode == 2){
     
     }
     
     // hit call
     if(callMode == 3){
     
     }
     }
     */

    // BLACKHOLE
    if(name.equals("blackhole")){
      // setup call
      if(callMode == 0){
        dmg = 1;

        // start acceleration (prevents its spawner)
        float startSpeed = 30;
        acc.add(cos(direction)*startSpeed, sin(direction)*startSpeed);
      }

      // draw call
      if(callMode == 1){
        // blackhole ability
        int startAttraction = 10;
        float strength = 0.01;
        if(frameCount-birthday > startAttraction){
          vol = 0;
          fill(255,100);
          ellipse(pos.x, pos.y, 10, 10);
          for(int i=0; i<missiles.size(); i++){
            Vect2 tmpPos = new Vect2(((Missile) missiles.get(i)).pos);
            Vect2 tmpDelta = new Vect2(pos);
            tmpDelta.sub(tmpPos);
            if(tmpDelta.magnitude2() != 0){
            float tmpDist2 = sq(tmpDelta.x) + sq(tmpDelta.y);
            float tmpAngle = atan2(tmpDelta.y, tmpDelta.x);
            float tmpMagnitude = strength; //1/pow(tmpDist2, -3);
            ((Missile) missiles.get(i)).acc.add(cos(tmpAngle)*tmpMagnitude, sin(tmpAngle)*tmpMagnitude);
            }
          }
          for(int i=0; i<astroids.size(); i++){
            Vect2 tmpPos = new Vect2(((Astroid) astroids.get(i)).pos);
            Vect2 tmpDelta = new Vect2(pos);
            tmpDelta.sub(tmpPos);
            if(tmpDelta.magnitude2() != 0){
            float tmpDist2 = sq(tmpDelta.x) + sq(tmpDelta.y);
            float tmpAngle = atan2(tmpDelta.y, tmpDelta.x);
            float tmpMagnitude = strength; //1/pow(tmpDist2, -3);
            ((Astroid) astroids.get(i)).acc.add(cos(tmpAngle)*tmpMagnitude, sin(tmpAngle)*tmpMagnitude);
            }
          }
        }
        /*
        for(int i=0; i<astroids.size(); i++) if(((Astroid) astroids.get(i)).is) ((Astroid) astroids.get(i)).draw(); // println("hey");
         else astroids.remove(i);
         
         for(int i=0; i<players.size(); i++) if(((Player) players.get(i)).is) ((Player) players.get(i)).draw();
         else players.remove(i);
         */
        // death due to age
        float maxAge = 500;
        if(frameCount-birthday > maxAge){
          is = false;
          specialAbilities(2);
        }
      }

      // death call
      if(callMode == 2){

      }

      // hit call
      if(callMode == 3){

      }
    }

    // forcewave
    if(name.equals("forcewave")){
      if(callMode == 0){
        int tmpNum = 10;
        float tmpWidth = TWO_PI*0.05;
        float tmpAngMax = direction + tmpWidth;
        float tmpAngMin = direction - tmpWidth;
        for(int i=0; i<tmpNum; i++){
          float tmpDir = (tmpAngMax - tmpAngMin)*((float)(i+1)/(float)tmpNum) +tmpAngMin;
          missiles.add(new Missile("forcewaveling", pos, vel, tmpDir));
        }
        is = false;
      }
    }

    if(name.equals("forcewaveling")){
      // setup call
      if(callMode == 0){
        dmg = 0;

        // start acceleration (prevents its spawner)
        float startSpeed = 30;
        acc.add(cos(direction)*startSpeed, sin(direction)*startSpeed);
      }

      // draw call
      if(callMode == 1){
        // push ability
        int startPush = 3;
        float minDist = 50;
        float tmpForce = 0.05;
        if(frameCount-birthday > startPush){
          for(int i=0; i<players.size(); i++){
            Vect2 tmpPos = new Vect2(((Player) players.get(i)).pos);
            Vect2 tmpDelta = new Vect2(pos);
            tmpDelta.sub(tmpPos);
            float tmpDist2 = tmpDelta.x*tmpDelta.x + tmpDelta.y*tmpDelta.y;
            if(minDist*minDist > tmpDist2){
              /* FIRST TRY
               float tmpForce = (minDist-sqrt(tmpDist2))*0.01;
               float tmpAng = atan2(tmpDelta.y, tmpDelta.x);
               Vect2 tmpAcc = new Vect2(cos(tmpAng)*tmpForce, sin(tmpAng)*tmpForce);
               */
              /* SECOND TRY
               float tmpForce = 0.1;
               Vect2 tmpAcc = new Vect2(vel);
               tmpAcc.mult(tmpForce);
               ((Player) players.get(i)).acc.add(tmpAcc);
               */

              // force
              Vect2 tmpVelDelta = new Vect2(((Player) players.get(i)).vel);
              tmpVelDelta.sub(vel);
              tmpVelDelta.mult(-1);
              ((Player) players.get(i)).acc.lerpVect2(tmpVelDelta, tmpForce);


              /* FIRST TRY
               float tmpEffectSize = PI*0.1;
               float tmpAng = atan2(-tmpDelta.y, -tmpDelta.x);
               noStroke();
               fill(255,abs(tmpVelDelta.magnitude()));
               arc(pos.x, pos.y, minDist*2, minDist*2, tmpAng - tmpEffectSize, tmpAng + tmpEffectSize);
               */

              // effect
              Vect2 tmpVel = new Vect2(((Player) players.get(i)).vel);
              stroke(255,50);
              strokeWeight(5);
              line(pos.x, pos.y, tmpPos.x + tmpVel.x, tmpPos.y + tmpVel.y);
            }
          }

          for(int i=0; i<astroids.size(); i++){
            Vect2 tmpPos = new Vect2(((Astroid) astroids.get(i)).pos);
            Vect2 tmpDelta = new Vect2(pos);
            tmpDelta.sub(tmpPos);
            float tmpDist2 = tmpDelta.x*tmpDelta.x + tmpDelta.y*tmpDelta.y;
            if(minDist*minDist > tmpDist2){
              /* FIRST TRY
               float tmpForce = (minDist-sqrt(tmpDist2))*0.01;
               float tmpAng = atan2(tmpDelta.y, tmpDelta.x);
               Vect2 tmpAcc = new Vect2(cos(tmpAng)*tmpForce, sin(tmpAng)*tmpForce);
               */
              /* SECOND TRY
               float tmpForce = 0.1;
               Vect2 tmpAcc = new Vect2(vel);
               tmpAcc.mult(tmpForce);
               ((astroid) astroids.get(i)).acc.add(tmpAcc);
               */

              // force
              Vect2 tmpVelDelta = new Vect2(((Astroid) astroids.get(i)).vel);
              tmpVelDelta.sub(vel);
              tmpVelDelta.mult(-1);
              ((Astroid) astroids.get(i)).acc.lerpVect2(tmpVelDelta, tmpForce);

              /* FIRST TRY
               float tmpEffectSize = PI*0.1;
               float tmpAng = atan2(-tmpDelta.y, -tmpDelta.x);
               noStroke();
               fill(255,abs(tmpVelDelta.magnitude()));
               arc(pos.x, pos.y, minDist*2, minDist*2, tmpAng - tmpEffectSize, tmpAng + tmpEffectSize);
               */

              // effect
              stroke(255,50);
              strokeWeight(5);
              line(pos.x, pos.y, tmpPos.x, tmpPos.y);
            }
          }
        }

        // death due to low speed & age
        float minVelocity = 10;
        float maxAge = 20;
        if(vel.magnitude2() < pow(minVelocity,2) && frameCount-birthday > maxAge){
          is = false;
          specialAbilities(2);
        }
      }

      // death call
      if(callMode == 2){

      }

      // hit call
      if(callMode == 3){

      }
    }

    // UNFAIR
    if(name.equals("unfair")){
      // setup call
      if(callMode == 0){        
        // call all other missiles and replace them with heatseeking
        for(int i=0; i<missiles.size(); i++){
          Vect2 tmpPos = new Vect2(((Missile) missiles.get(i)).pos);
          Vect2 tmpDelta = new Vect2(pos);
          tmpDelta.sub(tmpPos);
          if(tmpDelta.x != 0 && tmpDelta.y != 0) ((Missile) missiles.get(i)).name = "heatseeking";
        }

        is = false;
      }
    }

    // HEATSEEKING
    if(name.equals("heatseeking")){
      // setup call
      if(callMode == 0){
        dmg = random(7,10);

        // start acceleration (prevents its spawner)
        float startSpeed = 20;
        acc.add(cos(direction)*startSpeed, sin(direction)*startSpeed);
      }

      // draw call
      if(callMode == 1){
        // add acceleration first n frames
        float speed = 1;
        int fuelLimit = 500; // frames of burst
        if(frameCount-birthday < fuelLimit){
          acc.add(cos(direction)*speed, sin(direction)*speed);
        }

        // seek nearest player
        int updateTargetFrequency = 5;
        if(frameCount%updateTargetFrequency == 1){
          float dist2 = 100000;
          for(int i=0; i<players.size(); i++){
            Vect2 tmpPos = new Vect2(((Player) players.get(i)).pos);
            Vect2 tmpDelta = new Vect2(pos);
            tmpDelta.sub(tmpPos);
            float tmpDist2 = tmpDelta.x*tmpDelta.x + tmpDelta.y*tmpDelta.y;
            if(dist2>tmpDist2){
              dist2 = tmpDist2;

              // seektype FUTURE
              int frameCountCalculative = 4;
              Vect2 futurePos = new Vect2(vel);
              futurePos.mult(frameCountCalculative);
              direction = atan2(tmpDelta.y + futurePos.y, tmpDelta.x + futurePos.x) - PI;

              /* seektype LERP
               float lerpFactor = 0.2;
               direction = lerp(atan2(tmpDelta.y, tmpDelta.x) - PI, direction, lerpFactor);
               */
            }
          }
        }

        // death due to low speed & age
        float minVelocity = 5;
        float maxAge = 500;
        if(vel.magnitude2() < pow(minVelocity,2) && frameCount-birthday > maxAge){
          is = false;
          specialAbilities(2);
        }
      }

      // death call
      if(callMode == 2){

      }

      // hit call
      if(callMode == 3){

      }
    }

    // SPIRALSHOT
    if(name.equals("spiralshot")){
      // setup call
      if(callMode == 0){
        dmg = 30;
      }

      // draw call
      if(callMode == 1){
        // add acceleration first n frames
        float speed = 3;
        int fuelLimit = 100; // frames of burst
        if(frameCount-birthday < fuelLimit){
          acc.add(cos(direction)*speed, sin(direction)*speed);
        }

        // spiral ability
        int spiralLimit = 100;
        float spiralSpeed = 0.001;
        if(frameCount-birthday < spiralLimit){
          direction += TWO_PI*((frameCount-birthday)+50)*spiralSpeed;
        }

        // death due to low speed & age
        float minVelocity = 5;
        float maxAge = 100;
        if(vel.magnitude2() < pow(minVelocity,2) && frameCount-birthday > maxAge){
          is = false;
          specialAbilities(2);
        }
      }

      // death call
      if(callMode == 2){
        int explosionDensity = 30;
        for(int i=0; i<explosionDensity; i++){
          missiles.add(new Missile("spiralshotling", pos, vel, (TWO_PI/explosionDensity)*i + direction));
        }
      }
    }

    if(name.equals("spiralshotling")){
      // setup call
      if(callMode == 0){
        dmg = 20;

        // start acceleration (prevents its spawner)
        float startSpeed = 15;
        acc.add(cos(direction)*startSpeed, sin(direction)*startSpeed);
      }

      // draw call
      if(callMode == 1){
        // death due to low speed & age
        float minVelocity = 5;
        float maxAge = 10;
        if(vel.magnitude2() < pow(minVelocity,2) && frameCount-birthday > maxAge){
          is = false;
          specialAbilities(2);
        }
      }

      // death call
      if(callMode == 2){

      }
    }

    // ARROW
    if(name.equals("arrow")){
      // setup call
      if(callMode == 0){
        dmg = random(1,80);
        vol += dmg*0.5;

        // start acceleration (prevents its spawner)
        float startSpeed = 20;
        acc.add(cos(direction)*startSpeed, sin(direction)*startSpeed);
      }

      // draw call
      if(callMode == 1){
        // add acceleration first n frames
        float speed = 10;
        int fuelLimit = 2; // frames of burst
        if(frameCount-birthday < fuelLimit){
          acc.add(cos(direction)*speed, sin(direction)*speed);
        }

        // death due to low speed & age
        float minVelocity = 5;
        float maxAge = 2;
        if(vel.magnitude2() < pow(minVelocity,2) && frameCount-birthday > maxAge){
          is = false;
          specialAbilities(2);
        }
      }

      // death call
      if(callMode == 2){

      }
    }

    // FROZENORB
    if(name.equals("frozenorb")){
      // setup call
      if(callMode == 0){
        dmg = random(10,20);
      }

      // draw call
      if(callMode == 1){
        // add acceleration first n frames
        float speed = 0.3;
        int fuelLimit = 75; // frames of burst
        if(frameCount-birthday < fuelLimit){
          acc.add(cos(direction)*speed, sin(direction)*speed);
        }

        // frozenorb ability
        int frequency = 2;
        int startFrost = 25;
        if(frameCount%frequency == 1 && frameCount-birthday > startFrost){
          missiles.add(new Missile("frozenorbspike", pos, vel, random(TWO_PI)));
        }

        // death due to low speed & age
        float minVelocity = 3;
        float maxAge = 75;
        if(vel.magnitude2() < pow(minVelocity,2) && frameCount-birthday > maxAge){
          is = false;
          specialAbilities(2);
        }
      }

      // death call
      if(callMode == 2){
        // frozenorb death
        int explosionDensity = 6;
        for(int i=0; i<explosionDensity; i++){
          missiles.add(new Missile("frozenorbspike", pos, vel, (TWO_PI/explosionDensity)*i + direction));
        }
      }
    }

    if(name.equals("frozenorbspike")){
      // setup call
      if(callMode == 0){
        dmg = random(5,10);
      }

      // draw call
      if(callMode == 1){
        // add acceleration first n frames
        float speed = 0.4;
        int fuelLimit = 25; // frames of burst
        if(frameCount-birthday < fuelLimit){
          acc.add(cos(direction)*speed, sin(direction)*speed);
        }

        // death due to low speed & age
        float minVelocity = 4;
        float maxAge = 25;
        if(vel.magnitude2() < pow(minVelocity,2) && frameCount-birthday > maxAge){
          is = false;
          specialAbilities(2);
        }
      }

      // death call
      if(callMode == 2){

      }
    }
  }
}

/*
frozen orb
 chance bomb
 tree bomb
 tree bomb Piece
 shot
 sixcored bomb
 hotshooting missile
 mine
 breath
 */


















