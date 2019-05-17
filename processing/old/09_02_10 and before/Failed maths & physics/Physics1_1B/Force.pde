class Force{
  String type;
  Vect2 force;
  int id1, id2;
  float magnitude;

  Force(Vect2 force){
    type = "gravity";
    this.force = new Vect2(force);
  }

  Force(int id1, int id2, float distance){
    type = "constantDistance";
    this.id1 = id1;
    this.id2 = id2;
    this.magnitude = distance;
  }

  Force(String type, int id){
    this.type = type;
    id1 = id;
    ((Particle) particles.get(id1)).classification += type;
  }

  void upd(){
    if(type == "gravity"){
      for(int i=0; i<particles.size(); i++){
        ((Particle) particles.get(i)).acc.add(force);
      }
    }

    if(type == "mouseBound"){
      Vect2 tmpNewPos = new Vect2(mouseX, mouseY);
      ((Particle) particles.get(id1)).pos.set(tmpNewPos);
      ((Particle) particles.get(id1)).vel.set();
      ((Particle) particles.get(id1)).acc.set();
    }

    if(type == "constantDistance"){
      Vect2 tmpPos1 = new Vect2(((Particle) particles.get(id1)).pos);
      Vect2 tmpPos2 = new Vect2(((Particle) particles.get(id2)).pos);
      float tmpDist = dist(tmpPos1.x, tmpPos1.y, tmpPos2.x, tmpPos2.y);
      if(magnitude != tmpDist){
        float tmpAng2 = atan2(tmpPos2.y-tmpPos1.y, tmpPos2.x-tmpPos1.x);
        float tmpAng1 = tmpAng2+PI;
        float tmpDelta = (magnitude-tmpDist)*1;
        
        Vect2 tmpNewPos1 = new Vect2(tmpPos1);
        tmpNewPos1.add(cos(tmpAng1)*tmpDelta, sin(tmpAng1)*tmpDelta);
        
        Vect2 tmpNewPos2 = new Vect2(tmpPos2);
        tmpNewPos2.add(cos(tmpAng2)*tmpDelta, sin(tmpAng2)*tmpDelta);
        
        ((Particle) particles.get(id1)).pos.set(tmpNewPos1);
        ((Particle) particles.get(id1)).vel.set();
        //((Particle) particles.get(id2)).acc.set();
        
        ((Particle) particles.get(id2)).pos.set(tmpNewPos2);
        ((Particle) particles.get(id2)).vel.set();
        //((Particle) particles.get(id2)).acc.set();
      }
    }
  }

  void display(){
    if(type == "gravity"){
      noFill();
      strokeWeight(2);
      stroke(255,255,255,50);
      float tmpZoom = 50;
      float tmpLength = force.magnitude()*tmpZoom;
      line(tmpLength*0.5 + force.x*tmpZoom*0.5, tmpLength*0.5 + force.y*tmpZoom*0.5, tmpLength*0.5, tmpLength*0.5);
      ellipse(tmpLength*0.5, tmpLength*0.5, tmpLength, tmpLength);
    }

    if(type == "constantDistance"){
      noFill();
      strokeWeight(5);
      stroke(0,255,100,150);
      Vect2 tmpPos1 = new Vect2(((Particle) particles.get(id1)).pos);
      Vect2 tmpPos2 = new Vect2(((Particle) particles.get(id2)).pos);
      line(tmpPos1.x, tmpPos1.y, tmpPos2.x, tmpPos2.y);
    }
  }
}



