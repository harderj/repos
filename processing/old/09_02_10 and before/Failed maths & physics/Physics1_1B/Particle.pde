class Particle{
  Vect2 pos, vel, acc;
  int id;
  String classification = " ";
  
  Particle(int id){
    idNext ++;
    this.id = id;
    pos = new Vect2();
    vel = new Vect2();
    acc = new Vect2();
  }
  
  Particle(int id, Vect2 pos){
    idNext ++;
    this.id = id;
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
    ellipse(pos.x,pos.y,5,5);
  }
}
