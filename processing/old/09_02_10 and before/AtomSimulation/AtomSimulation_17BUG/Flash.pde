class Flash{

  boolean active = true;
  float x,y;
  float vol = 5;
  float exspandRate = flashExspandRate;
  int life = 25;
  int combineCount = flashCombineCount;
  int strokeVolume = flashStrokeVolume;

  Flash(float x, float y){
    this.x = x;
    this.y = y;
  }

  void draw(){
    if(active){
      age();
      exspand();
      if(!unitSpreading) combine();
      render();
    }
  }

  void age(){
    life --;
    if(life < 1){
      active = false;
    }
  }

  void exspand(){
    vol += exspandRate;
  }

  void combine(){
    float tmpN = 0;
    float tmpX = 0;
    float tmpY = 0;
    float tmpV = 0;
    boolean tmpA = true;
    for(int i=0; i<flashs.size(); i++){
      tmpX = ((Flash) flashs.get(i)).x;
      tmpY = ((Flash) flashs.get(i)).y;
      tmpV = ((Flash) flashs.get(i)).vol;
      tmpA = ((Flash) flashs.get(i)).active;
      if(dist(x,y,tmpX,tmpY) < (vol + tmpV)*0.5 && dist(x,y,tmpX,tmpY) > 0.1 && tmpA){
        tmpN ++;
      }
    }

    if(tmpN > combineCount){
      for(int i=0; i<flashs.size(); i++){
        if(dist(x,y,tmpX,tmpY) < (vol + tmpV)*0.5 && dist(x,y,tmpX,tmpY) > 0.1 && tmpA){
          ((Flash) flashs.get(i)).active = false;
        }
      }
      explosions.add(new Explosion(x,y));
      active = false;
    }
  }

  void render(){
    noFill();
    strokeWeight(strokeVolume);
    stroke(255,200,0,125);
    ellipse(x,y,vol,vol);
  }
}
