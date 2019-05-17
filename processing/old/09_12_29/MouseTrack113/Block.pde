class Block{
  boolean is;
  PVector pos, vel, acc;
  float r;
  

  Block(PVector pos, float r){
    is = true;
    
    this.r = r;
    this.pos = new PVector(pos.x, pos.y, 0.0);
    vel = new PVector(0.0, 0.0);
    acc = new PVector(0.0, 0.0);
  }

  void draw(){
    hitStones();
    
    noStroke();
    fill(0,100,0,100);

    ellipse(pos.x,pos.y,r*2,r*2);
  }
  
  void hitStones(){
    float offset = 1.01;
    
    for(int i=0; i<stones.size(); i++){
      PVector tPos = new PVector(((Stone) stones.get(i)).pos.x, ((Stone) stones.get(i)).pos.y);
      float tR = ((Stone) stones.get(i)).r;
      float d2 = ((pos.x-tPos.x)*(pos.x-tPos.x)+(pos.y-tPos.y)*(pos.y-tPos.y));
      
      if(d2 < r*r + tR*tR){
        PVector tVel = new PVector(((Stone) stones.get(i)).vel.x, ((Stone) stones.get(i)).vel.y);
        PVector tAcc = new PVector(((Stone) stones.get(i)).acc.x, ((Stone) stones.get(i)).acc.y);
        float a = atan2(pos.y-tPos.y, pos.x-tPos.x);
        float d = sqrt(d2);
        
        println(d);
        
        tPos.set(pos.x + cos(a)*d*offset, pos.y + sin(a)*d*offset, 0.0);
        
        ((Stone) stones.get(i)).pos.set(tPos);
        ((Stone) stones.get(i)).vel.set(tVel);
        ((Stone) stones.get(i)).acc.set(tAcc);
      }
    }
  }
}
