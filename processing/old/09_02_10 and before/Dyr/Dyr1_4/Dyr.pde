class Dyr{
  boolean is = true;
  V2 pos, vel, acc;
  float sMass, mass, mouth, sSpeed, speed, dir, dirVel;
  int splitCount;
  color pig;

  Dyr(V2 pos, float mass, float mouth, float speed, int splitCount, color pigment){
    this.pos = new V2(pos);
    this.mass = mass;
    sMass = mass;
    this.mouth = mouth;
    this.speed = 0;
    this.sSpeed = speed;
    this.splitCount = splitCount;
    dir = random(TWO_PI);
    dirVel = 0;
    pig = pigment;

    acc = new V2();
    vel = new V2();
  }

  void upd(){
    split();
    eat();
    move();
    basics();
    render();
  }

  void split(){
    if(splitCount*sMass < mass){
      is = false;

      for(int i=0; i<splitCount; i++){
        pig = color(red(pig)*random(1-gMutation, 1+gMutation), green(pig)*random(1-gMutation, 1+gMutation), blue(pig)*random(1-gMutation, 1+gMutation));
        mouth *= random(1-gMutation, 1+gMutation);
        speed *= random(1-gMutation, 1+gMutation);
        if(random(10)<2){
          splitCount += int(random(2,-2));
          sMass = (mass*random(1-gMutation, 1+gMutation)) / splitCount;
        } 
        else {
          sMass *= random(1-gMutation, 1+gMutation);
        }
        pos.x *= random(1-gMutation, 1+gMutation);
        pos.y *= random(1-gMutation, 1+gMutation);
        dyrs.add(new Dyr(pos, sMass, mouth, speed, splitCount, pig));
        }
      }
    }

    void eat(){
      for(int i=0; i<alges.size(); i++){
        float tMass = ((Alge) alges.get(i)).mass;
        if(tMass < mouth*gMouthMax && tMass > mouth*gMouthMin){
          V2 tPos = new V2(((Alge) alges.get(i)).pos);
          if(dist(pos.x + cos(dir)*(mass+mouth)*0.5,pos.y +sin(dir)*(mass+mouth)*0.5,tPos.x,tPos.y)<mouth){
            ((Alge) alges.get(i)).is = false;
            mass += tMass*gFoodUseability;
          }
        }
      }
    }

  void basics(){
    dirVel *= gRotateDrag;
    dir += dirVel;

    acc.add(gGravity);
    vel.add(acc);
    acc.set(0);
    vel.mult(gDrag);
    pos.add(vel);

    if(pos.x < 0){
      pos.x = 0;
      vel.x = 0;
    }
    if(pos.x > width){
      pos.x = width;
      vel.x = 0;
    }
    if(pos.y < 0){
      pos.y = 0;
      vel.y = 0;
    }
    if(pos.y > height){
      pos.y = height;
      vel.y = 0;
    }
  }

  void move(){
    speed += random(sSpeed*0.8,sSpeed/0.8);
    if(random(1000)<speed){
      acc.x += cos(dir)*gSpeed*mass;
      acc.y += sin(dir)*gSpeed*mass;


      mass -= gLoss*gSpeed*mass;
      speed = 0;
    }
    if(vel.magnitude()<gSpeed && dirVel<gRotateSpeed*0.01 && speed<sSpeed){
      dirVel += random(-gRotateSpeed,gRotateSpeed);
    }
  }

  void render(){
    noStroke();
    fill(pig);
    ellipse(pos.x, pos.y, mass, mass);
    //mouth
    noFill();
    strokeWeight(2);
    stroke(pig);
    arc(pos.x+cos(dir)*(mass+mouth)*0.5, pos.y+sin(dir)*(mass+mouth)*0.5, mouth, mouth, dir + HALF_PI, dir - HALF_PI);
  }
}
