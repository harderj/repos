class Missile{
  boolean act = true;

  String name;
  Vect2 pos, vel, acc;


  Missile(String name, Vect2 pos, Vect2 vel){
    this.pos = new Vect2(pos);
  }

  void draw(){
    specialAbilities();
    updateBaseValues();
    render();
  }
  
  void specialAbilities(){
    
  }
  
  void updateBaseValues(){
    vel.add(acc);
    pos.add(vel);
    acc.set();
  }

  void checkHitWall(){
    if(x<0 || y<0 || x>width || y>height){
      act = false;
    }
  }

  void render(){
    //body
    float tmp = 2;
    if(name == "frozen orb") tmp = 6;
    if(name == "chance bomb") tmp = 4;
    if(name == "tree bomb") tmp = 5;
    if(name == "tree bomb Piece") tmp = 3;
    if(name == "shot") tmp = 3;
    if(name == "sixcored bomb") tmp = 8;
    if(name == "hotshooting missile") tmp = 4;
    if(name == "mine") tmp = 7;
    if(name == "breath") tmp = 2;
    noStroke();
    if(owner == 0) fill(255,0,0);
    if(owner == 1) fill(0,255,0);
    if(owner == 2) fill(255);
    Triangle(x,y,dir,tmp);
  }
}
