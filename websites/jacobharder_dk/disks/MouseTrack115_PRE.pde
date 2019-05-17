ArrayList stones, blocks;

PVector pos, vel, acc;
float drag = 0.99;

void setup(){
  size(500,500);
  smooth();
  frameRate(50);
  ellipseMode(CENTER);

  stones = new ArrayList();
  blocks = new ArrayList();

  stones.add(new Stone(new PVector(0.0, 0.0)));
  blocks.add(new Block(new PVector(random(width)-width*0.5, random(height)-height*0.5), 50));

  pos = new PVector(0,0);
  vel = new PVector(0,0);
  acc = new PVector(0,0);
}

void draw(){
  background(255);
  translate(width*0.5, height*0.5);
  
  updateLists();
}

void keyPressed(){
  if(key == 's') stones.add(new Stone(new PVector(0.0, 0.0)));
  if(key == 'b') blocks.add(new Block(new PVector(mouseX-width*0.5, mouseY-height*0.5), 50));
}

void updateLists(){
  for(int i=0; i<stones.size(); i++){
    if(((Stone) stones.get(i)).is){
      ((Stone) stones.get(i)).mouseAttractNormal();
      ((Stone) stones.get(i)).draw();
    }
    else {
      stones.remove(i);
    }
  }
  
  for(int i=0; i<blocks.size(); i++){
    if(((Block) blocks.get(i)).is){
      ((Block) blocks.get(i)).draw();
    }
    else {
      blocks.remove(i);
    }
  }
  
  for(int i=0; i<stones.size(); i++){
    ((Stone) stones.get(i)).render();
  }
}
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
class Stone{
  boolean is;
  PVector pos, vel, acc;
  float r;

  Stone(PVector pos){
    is = true;
    r = 10;
    
    this.pos = new PVector(pos.x, pos.y, 0.0);
    vel = new PVector(0.0, 0.0);
    acc = new PVector(0.0, 0.0);
  }

  void draw(){
    vel.add(acc);
    acc.set(0,0,0);
    vel.mult(drag);
    pos.add(vel);
  }
  
  void render(){
    noStroke();
    fill(0,50);

    ellipse(pos.x,pos.y,r*2,r*2);
  }
  
  void mouseAttractNormal(){
    float speed = 0.2;

    noStroke();
    fill(255,0,0);
    PVector m = new PVector(mouseX-width*0.5, mouseY-height*0.5);

    ellipse(m.x, m.y, 5, 5);

    if(m != null && pos != null){
      acc.x = cos(atan2(-pos.y+m.y, -pos.x+m.x))*speed;
      acc.y = sin(atan2(-pos.y+m.y, -pos.x+m.x))*speed;
    }
  }
  
  void mouseAttractGravity(){
    float speed = 10;

    noStroke();
    fill(255,0,0);
    PVector m = new PVector(mouseX-width*0.5, mouseY-height*0.5);

    ellipse(m.x, m.y, r*2, r*2);

    if(m != null && pos != null){
      acc.x = cos(atan2(-pos.y+m.y, -pos.x+m.x))*(1/sqrt((pos.x-m.x)*(pos.x-m.x)+(pos.y-m.y)*(pos.y-m.y)))*speed;
      acc.y = sin(atan2(-pos.y+m.y, -pos.x+m.x))*(1/sqrt((pos.x-m.x)*(pos.x-m.x)+(pos.y-m.y)*(pos.y-m.y)))*speed;
    }
  }

  void mousePush(){
    float speed = 10;

    noStroke();
    fill(255,0,0);
    PVector m = new PVector(mouseX-width*0.5, mouseY-height*0.5);

    ellipse(m.x, m.y, r*2, r*2);

    if(m != null && pos != null){
      acc.x = cos(atan2(pos.y-m.y, pos.x-m.x))*(1/((pos.x-m.x)*(pos.x-m.x)+(pos.y-m.y)*(pos.y-m.y)))*speed;
      acc.y = sin(atan2(pos.y-m.y, pos.x-m.x))*(1/((pos.x-m.x)*(pos.x-m.x)+(pos.y-m.y)*(pos.y-m.y)))*speed;
    }
  }
}




