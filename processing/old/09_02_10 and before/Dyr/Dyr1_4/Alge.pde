class Alge{
  boolean is = true;
  V2 pos = new V2();
  float mass;

  Alge(V2 pos){
    this.pos.set(pos);
    mass = random(gAlgeSize*0.5,gAlgeSize/0.5);
  }

  void upd(){
    mass += random(0,gAlgeGrowth);
    noFill();
    strokeWeight(1+mass*0.2);
    stroke(100,255,100);
    ellipse(pos.x,pos.y,mass,mass);
  }
}
