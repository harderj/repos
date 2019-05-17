class Missile{
  boolean is = true;

  String name;
  Vect2 pos, vel, acc;
  float direction;
  float dmg = 1;
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
    float tmp = 5;

    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, tmp, tmp);
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
              int frameCountCalculative = 3;
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
        int explosionDensity = 15;
        for(int i=0; i<explosionDensity; i++){
          missiles.add(new Missile("spiralshotling", pos, vel, (TWO_PI/explosionDensity)*i + direction));
        }
      }
    }

    if(name.equals("spiralshotling")){
      // setup call
      if(callMode == 0){
        dmg = 20;
      }

      // draw call
      if(callMode == 1){
        // add acceleration first n frames
        float speed = 3;
        int fuelLimit = 3; // frames of burst
        if(frameCount-birthday < fuelLimit){
          acc.add(cos(direction)*speed, sin(direction)*speed);
        }

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
        dmg = random(1,50);
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








