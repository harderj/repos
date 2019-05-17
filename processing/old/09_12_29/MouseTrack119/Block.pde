class Block{
  boolean is = true;
  String type; // ellipse, line ..
  PVector pos, vel, acc;
  float r, l, a; // radius, length, angle

  Block(PVector pos, float r){ // ellipse constructor
    type = "ellipse";

    this.r = r;
    this.pos = new PVector(pos.x, pos.y, 0.0);
    vel = new PVector(0.0, 0.0);
    acc = new PVector(0.0, 0.0);
  }

  Block(PVector pos1, PVector pos2){ // line constructor
    type = "line";

    l = dist(pos1.x, pos1.y, pos2.x, pos2.y);
    a = atan2(pos1.y-pos2.y, pos1.x-pos2.x);
    r = 3;
    // 3 is currently default line radius.
    //The radius says something about the thickness in case of a line. If r=2, the line is 4 pixels wide.

    this.pos = new PVector((pos1.x+pos2.x)*0.5, (pos1.y+pos2.y)*0.5, 0.0);
    vel = new PVector(0.0, 0.0);
    acc = new PVector(0.0, 0.0);
  }

  void draw(){
    hitStones();

    render();
  }

  void render(){
    if(type == "line"){
      stroke(0,0,255,100);
      strokeWeight(r*2);

      line(pos.x-cos(a)*l*0.5, pos.y-sin(a)*l*0.5, pos.x+cos(a)*l*0.5, pos.y+sin(a)*l*0.5);
    }

    if(type == "ellipse"){
      noStroke();
      fill(0,100,0,100);

      ellipse(pos.x,pos.y,r*2,r*2);
    }
  }

  void hitStones(){
    if(type == "line"){
      for(int i=0; i<stones.size(); i++){
        PVector tPos = new PVector(((Stone) stones.get(i)).pos.x, ((Stone) stones.get(i)).pos.y); // temporary variable for the position of the stone being considered
        float tR = ((Stone) stones.get(i)).r; // temporary radius for that stone
        PVector rPos = new PVector(); // rotated thus relative position of the stone 
        PVector pos1 = new PVector(); // rotated thus neutral position of the left end of the line (left means lesser x-values in the pixel-array)
        PVector pos2 = new PVector(); // rotated thus neutral position of the right end of the line (right means greater x-values)
        rPos.set(rotateAround(tPos, pos, -a));
        pos1.set(rotateAround(new PVector(pos.x-cos(a)*l*0.5, pos.y-sin(a)*l*0.5), pos, -a));
        pos2.set(rotateAround(new PVector(pos.x+cos(a)*l*0.5, pos.y+sin(a)*l*0.5), pos, -a));

        if(checkMode){
          noStroke();
          fill(0,0,0,100);

          ellipse(rPos.x,rPos.y,r*2,r*2);

          stroke(0,0,0,100);
          strokeWeight(r*2);
          line(pos1.x, pos1.y, pos2.x, pos2.y);
        }
        
        if(abs(rPos.y-pos1.y) < r + tR && rPos.x > pos1.x - (r + tR) && rPos.x < pos2.x + (r + tR)){
          PVector rVel = new PVector(); // rotated thus relative velocity of the stone
          rVel.set(rotateAround(((Stone) stones.get(i)).vel, new PVector(0.0, 0.0), -a));
          
          if(checkMode) ellipse(pos.x, pos.y, 20, 20); // for debug
          
          //rVel.y *= 0;
          rVel.y *= -1;
          
          if(rVel.y > 0) rPos.y = pos1.y + (r + tR);
          else rPos.y = pos1.y - (r + tR);
          
          ((Stone) stones.get(i)).pos.set(rotateAround(rPos, pos, a));
          ((Stone) stones.get(i)).vel.set(rotateAround(rVel, new PVector(0.0, 0.0), a));
        }
      }
    }

    if(type == "ellipse"){
      float offset = 1.0;
      float friction = 0.9;

      for(int i=0; i<stones.size(); i++){
        PVector tPos = new PVector(((Stone) stones.get(i)).pos.x, ((Stone) stones.get(i)).pos.y);
        float tR = ((Stone) stones.get(i)).r;
        float d2 = ((pos.x-tPos.x)*(pos.x-tPos.x)+(pos.y-tPos.y)*(pos.y-tPos.y));

        if(checkCollision(tPos, pos, tR, r)){
           PVector tVel = new PVector(((Stone) stones.get(i)).vel.x, ((Stone) stones.get(i)).vel.y);
          
          ((Stone) stones.get(i)).pos.set(keepCirclesGlued(tPos, pos, tR, r));
          ((Stone) stones.get(i)).vel.set(calcVelCircleCollision(tPos, pos, tVel));
          
          
          
          /*
          PVector tVel = new PVector(((Stone) stones.get(i)).vel.x, ((Stone) stones.get(i)).vel.y);
          float d = sqrt(d2);
          float mStoneVel = dist(0,0,tVel.x, tVel.y);
          float aImpact = atan2(tPos.y-pos.y, tPos.x-pos.x);
          float aStoneVel = atan2(tVel.y, tVel.x);
          float aOut = 2*aImpact-aStoneVel+PI;

          if(checkMode){
            strokeWeight(3);
            stroke(255,0,0);
            line(pos.x, pos.y, pos.x+cos(aOut)*10, pos.y+sin(aOut)*10);
            stroke(0,0,255);
            line(pos.x, pos.y, pos.x+cos(aImpact)*10, pos.y+sin(aImpact)*10);
          }

          tPos.set(pos.x + cos(aImpact)*(r+tR)*offset, pos.y + sin(aImpact)*(r+tR)*offset, 0.0);
          tVel.set(cos(aOut)*mStoneVel, sin(aOut)*mStoneVel, 0.0);
          tVel.mult(friction);
          //tVel.set(0.0, 0.0, 0.0);

          ((Stone) stones.get(i)).pos.set(tPos);
          ((Stone) stones.get(i)).vel.set(tVel);
          */
        }
      }
    }
  }
}









