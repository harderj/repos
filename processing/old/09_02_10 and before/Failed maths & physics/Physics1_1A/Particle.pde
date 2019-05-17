class Particle{
  Vect2 pos, vel, acc;
  String classification = " ";
  
  Particle(){
    pos = new Vect2();
    vel = new Vect2();
    acc = new Vect2();
  }
  
  Particle(Vect2 pos){
    this.pos = new Vect2(pos);
    vel = new Vect2();
    acc = new Vect2();
  }
  
  void upd(){
    vel.add(acc);
    pos.add(vel);
    acc.set();
  }
  
  void display(){
    noStroke();
    fill(255);
    ellipse(pos.x,pos.y,10,10);
  }
}
