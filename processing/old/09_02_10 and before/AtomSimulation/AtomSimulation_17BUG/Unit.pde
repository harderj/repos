class Unit{

  boolean active = true;
  float x,y,speX,speY;
  int life;

  Unit(float x, float y, float speX, float speY){
    this.x = x;
    this.y = y;
    this.speX = speX;
    this.speY = speY;
    life = int(random(lifeMin, lifeMax));
  }

  void draw(){
    if(active){
      age();
      if(unitSpreading) avoidFlashs();
      else avoidExplosions();
      move();
      render();
    }
  }

  void age(){
    life --;
    if(life < 1){
      active = false;
      if(x>0 && x<width && y>0 && y<height) explode();
    }
  }

  void explode(){
    flashs.add(new Flash(x,y));
    for(int i=0; i<splits; i++){
      units.add(new Unit(x,y,random(-speed,speed),random(-speed,speed)));
    }
    energyCounter ++;
  }

  void avoidFlashs(){
    for(int i=0; i<flashs.size(); i++){
      float tmpX = ((Flash) flashs.get(i)).x;
      float tmpY = ((Flash) flashs.get(i)).y;
      float tmpV = ((Flash) flashs.get(i)).vol;
      float tmpA = atan2(y-tmpY,x-tmpX);
      if(dist(x,y,tmpX,tmpY) < tmpV/2){
        speX += cos(tmpA)*(speed*0.02);
        speY += sin(tmpA)*(speed*0.02);
      }
    }
  }

  void avoidExplosions(){
    for(int i=0; i<explosions.size(); i++){
      float tmpX = ((Explosion) explosions.get(i)).x;
      float tmpY = ((Explosion) explosions.get(i)).y;
      float tmpV = ((Explosion) explosions.get(i)).vol;
      float tmpA = atan2(y-tmpY,x-tmpX);
      if(dist(x,y,tmpX,tmpY) < tmpV/2){
        speX += cos(tmpA)*(speed*(tmpV/(explosionLife*explosionExspandRate)));
        speY += sin(tmpA)*(speed*(tmpV/(explosionLife*explosionExspandRate)));
      }
      if(i==0){
        //println(tmpV/(explosionLife*explosionExspandRate));
      }
    }
  }

  void move(){
    x += speX;
    y += speY;
  }

  void render(){
    noStroke();
    fill(255);
    ellipse(x,y,volume,volume);
  }
}
