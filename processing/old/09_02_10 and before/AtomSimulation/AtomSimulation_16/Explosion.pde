class Explosion{

  boolean active = true;
  float x,y;
  float vol = 5;
  float exspandRate = explosionExspandRate;
  int life = explosionLife;
  int strokeVolume = explosionStrokeVolume;

  Explosion(float x, float y){
    this.x = x;
    this.y = y;
  }

  void draw(){
    if(active){
      age();
      exspand();
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

  void render(){
    noFill();
    strokeWeight(strokeVolume);
    stroke(255,255,255,200);
    ellipse(x,y,vol,vol);
  }
}
