class Sunling{
  boolean act = true;
  
  boolean alive;
  float x,y;
  float xV,yV;
  float xA,yA;
  float e, breedE;

  Sunling(float x, float y, float energy){
    this.x = x;
    this.y = y;
    e = energy;
    breedE = e*2 + (random(e,-e)*mutativity);
    alive = true;
  }

  void draw(){
    if(alive){
    updatePos();
    hitFrames();
    hitSunlings();
    hitRays();
    updateE();
    }
    render();
  }
  
  void updateE(){
    e --;
    if(e < 0) death();
    if(e > breedE) breed();
  }
  
  void updatePos(){
    yA += gravity;
    
    xV += xA;
    yV += yA;
    
    xV *= 0.75;
    yV *= 0.95;
    
    x += xV;
    y += yV;
    
    xA = 0;
    yA = 0;
  }
  
  void breed(){
    act = false;
    float tmp = breedE/2;
    sunlings.add(new Sunling(x,y,tmp));
    sunlings.add(new Sunling(x,y,tmp));
  }
  
  void death(){
    alive = false;
    int tmp = int(breedE/30);
  }
  
  void hitRays(){
    for(int i=0; i<rays.size(); i++){
      if((((Ray) rays.get(i)).x > width/2 && x > width/2) || (((Ray) rays.get(i)).x < width/2 && x < width/2)){
        if(dist(((Ray) rays.get(i)).x,((Ray) rays.get(i)).y,x,y) < e/25+5){
          ((Ray) rays.get(i)).act = false;
          e += rayEnergy;
        }
      }
    }
  }
  
  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }   
  }
  
  void render(){
    color tmp = 255;
    if(breedE < 255*6) tmp = color(255,breedE,255);
    if(breedE < 255*5) tmp = color(breedE,0,255);
    if(breedE < 255*4) tmp = color(0,255-breedE,255);
    if(breedE < 255*3) tmp = color(0,255,breedE);
    if(breedE < 255*2) tmp = color(255-breedE,255,0);
    if(breedE < 255) tmp = color(255,breedE,0);
    if(!alive) tmp = color(120);
    noFill();
    stroke(tmp,255);
    strokeWeight(int(e/25)+3);
    ellipse(x,y,20,20);
  }
}
