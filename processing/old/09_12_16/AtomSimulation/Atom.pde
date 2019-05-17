class Atom{
  boolean is = true;
  int id;
  float radius = 5;
  PVector pos, vel, acc;

  Atom(){
    pos = new PVector(0, 0);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  Atom(PVector position){
    pos = new PVector(position.x, position.y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  Atom(PVector position, PVector velocity){
    pos = new PVector(position.x, position.y);
    vel = new PVector(velocity.x, velocity.y);
    acc = new PVector(0, 0);
  }

  void update(int i){
    id = i;
    reject();
    hitScreen();
    basic();
    render();
  }

  void reject(){
    int tmpSize = atoms.size();
    for(int i=id+1; i!=id; i=(i+1)%tmpSize){
      //println("id: " + id + " & i: " + i);
      /*
      PVector tmpPos = new PVector(((Atom) atoms.get(i)).pos.x, ((Atom) atoms.get(i)).pos.y);
      PVector tmpDelta = new PVector(pos.x-tmpPos.x, pos.y-tmpPos.y);
      float tmpDist2 = tmpDelta.x*tmpDelta.x + tmpDelta.y*tmpDelta.y;
      float tmpMinDist2 = 20*20;

      if(tmpDist2 < tmpMinDist2){
        float tmpAngle = atan2(tmpDelta.y, tmpDelta.x);
        float tmpMag = (1/tmpDist2)*10;
        acc.add(cos(tmpAngle)*tmpMag, sin(tmpAngle)*tmpMag, 0);
      }
      */
    }
    int i = (id+1)%tmpSize;
    while(i!=id){
      PVector tmpPos = new PVector(((Atom) atoms.get(i)).pos.x, ((Atom) atoms.get(i)).pos.y);
      PVector tmpDelta = new PVector(pos.x-tmpPos.x, pos.y-tmpPos.y);
      float tmpDist2 = tmpDelta.x*tmpDelta.x + tmpDelta.y*tmpDelta.y;
      float tmpRadius = ((Atom) atoms.get(i)).radius;
      float tmpMinDist2 = (radius*radius + tmpRadius*tmpRadius)*100;

      if(tmpDist2 < tmpMinDist2){
        
        float tmpAngle = atan2(tmpDelta.y, tmpDelta.x);
        float tmpMag = (1/(1+(tmpDist2*0.0001)));
        acc.add(cos(tmpAngle)*tmpMag, sin(tmpAngle)*tmpMag, 0);
        ((Atom) atoms.get(i)).acc.add(cos(tmpAngle-PI)*tmpMag, sin(tmpAngle-PI)*tmpMag, 0);
        
        /*
        PVector tmpVel = new PVector(((Atom) atoms.get(i)).vel.x, ((Atom) atoms.get(i)).vel.y);
        PVector tmpVelTmp = new PVector(((Atom) atoms.get(i)).vel.x, ((Atom) atoms.get(i)).vel.y);
        tmpVel.lerp
        */
      }
      
      i = (i+1)%tmpSize;
    }
  }

  void hitScreen(){
    if(pos.x<0 || pos.x>width){
      pos.x = constrain(pos.x, 0, width);
      vel.x *= -1;
      vel.mult(drag);
    }
    if(pos.y<0 || pos.y>height){
      pos.y = constrain(pos.y, 0, height);
      vel.y *= -1;
      vel.mult(drag);
    }
  }

  void basic(){
    acc.add(gravity);
    vel.add(acc);
    vel.mult(drag);
    pos.add(vel);
    acc.set(0, 0, 0);
  }

  void render(){
    noStroke();
    fill(0);
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
}

