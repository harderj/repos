class Force{
  String type;
  Vect2 force;
  Particle p1, p2;
  float magnitude;

  Force(Vect2 force){
    type = "gravity";
    this.force = new Vect2(force);
  }

  Force(Particle p1, Particle p2, float distance){
    type = "constantDistance";
    this.p1 = p1;
    this.p2 = p2;
    this.magnitude = distance;
  }

  Force(String type, Particle p){
    this.type = type;
    p1 = p;
    p1.classification += type;
  }

  void upd(){
    if(type == "gravity"){
      /*
      for(int i=0; i<particles.size(); i++){
        ((Particle) particles.get(i)).acc.add(force);
      }
      */
    }

    if(type == "constantDistance"){
      /*
      Vect2 tmpPos1 = new Vect2(((Particle) particles.get(p1)).pos);
      Vect2 tmpPos2 = new Vect2(((Particle) particles.get(p2)).pos);
      if(magnitude != dist(tmpPos1.x, tmpPos1.y, tmpPos2.x, tmpPos2.y)){
        float tmpAng = atan2(tmpPos2.y-tmpPos1.y, tmpPos2.x-tmpPos1.x);
        Vect2 tmpNewPos = new Vect2(tmpPos1.x + cos(tmpAng)*magnitude, tmpPos1.y + sin(tmpAng)*magnitude);
        ((Particle) particles.get(p2)).pos.set(tmpNewPos);
        ((Particle) particles.get(p2)).vel.set();
        //((Particle) particles.get(p2)).acc.set();
      }
      */
    }

    if(type == "mouseBound"){
      Vect2 tmpNewPos = new Vect2(mouseX, mouseY);
      p1.pos.set(tmpNewPos);
      p1.vel.set();
      p1.acc.set();
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
      line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);
    }
  }
}



