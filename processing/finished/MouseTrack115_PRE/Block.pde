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
    float offset = 1.0;
    
    for(int i=0; i<stones.size(); i++){
      PVector tPos = new PVector(((Stone) stones.get(i)).pos.x, ((Stone) stones.get(i)).pos.y);
      float tR = ((Stone) stones.get(i)).r;
      float d2 = ((pos.x-tPos.x)*(pos.x-tPos.x)+(pos.y-tPos.y)*(pos.y-tPos.y));
      
      if(d2 < (r + tR)*(r + tR)){
        PVector tVel = new PVector(((Stone) stones.get(i)).vel.x, ((Stone) stones.get(i)).vel.y);
        PVector tAcc = new PVector(((Stone) stones.get(i)).acc.x, ((Stone) stones.get(i)).acc.y);
        float d = sqrt(d2);
        float mStoneVel = dist(0,0,tVel.x, tVel.y);
        float aImpact = atan2(tPos.y-pos.y, tPos.x-pos.x);
        float aStoneVel = atan2(tVel.y, tVel.x);
        float aOut = 2*aImpact-aStoneVel+PI;
        
        strokeWeight(3);
        stroke(255,0,0);
        line(pos.x, pos.y, pos.x+cos(aOut)*10, pos.y+sin(aOut)*10);
        stroke(0,255,0);
        line(pos.x, pos.y, pos.x+cos(aImpact)*10, pos.y+sin(aImpact)*10);
        stroke(0,0,255);
        line(pos.x, pos.y, pos.x+cos(aStoneVel)*10, pos.y+sin(aStoneVel)*10);
        
        tPos.set(pos.x + cos(aImpact)*(r+tR)*offset, pos.y + sin(aImpact)*(r+tR)*offset, 0.0);
        tVel.set(cos(aOut)*mStoneVel, sin(aOut)*mStoneVel, 0.0);
        //tVel.set(0.0, 0.0, 0.0);
        
        ((Stone) stones.get(i)).pos.set(tPos);
        ((Stone) stones.get(i)).vel.set(tVel);
        ((Stone) stones.get(i)).acc.set(tAcc);
      }
    }
  }
}
