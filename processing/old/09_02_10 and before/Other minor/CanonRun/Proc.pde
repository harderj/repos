class Proc{
  boolean act = true;
  Vect2 pos = new Vect2();
  Vect2 vel = new Vect2();
  Vect2 acc = new Vect2();
  String kind;
  String shape;
  color col;
  
  Proc(Vect2 position, Vect2 velocity, String kind, color col){
    pos.set(position);
    vel.set(velocity);
    this.kind = kind;
    this.col = col;
    
    shape = "default";
    
    if(kind == "shot"){
      shape = "shot";
    }
  }
  
  void draw(){
    updatePos();
    checkDeath();
    render();
  }
  
  void updatePos(){
    acc.add(gravity);
    vel.add(acc);
    vel.mult(drag);
    pos.add(vel);
  }
  
  void checkDeath(){
    if(kind == "" || kind == " " || kind == "default" || kind == "shot"){
      frameDeath();
    }
  }
  
  void frameDeath(){
    if(pos.x < 0 || pos.x > width || pos.y > height){
      die();
    }
  }
  
  void die(){
    if(kind == "" || kind == " " || kind == "default" || kind == "shot"){
      act = false;
    }
  }
  
  void render(){
    if(shape == "default"){
      noStroke();
      fill(col);
      ellipse(pos.x, pos.y, 20, 20);
    }
    if(shape == "shot"){
      stroke(col);
      strokeWeight(2);
      line(pos.x, pos.y, pos.x - vel.x, pos.y - vel.y);
    }
  }
}
