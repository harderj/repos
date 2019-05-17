class Rigid implements iRigid{
  
  Point2 pos, vel, acc;
  float mass, rotate, rotating;
  
  Rigid(){
    
  }
  
  void update(){
    acc.add(0, GRAVITY);
    vel.add(acc);
    vel.scale(DRAG);
    acc.setZero();
    pos.add(vel);
    move();
    rotate += rotating;
  }
  
  void move(){
    
  }
}
