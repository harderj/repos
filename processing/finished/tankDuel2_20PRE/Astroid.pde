class Astroid{

  int x,y;
  float speX,speY,vol;
  float dir,dirSpe;
  boolean act = true;
  int life;
  int edges= 5;
  float[] thingy = new float[edges];

  Astroid(int x, int y, float dir, float spe, float vol){
    this.x = x;
    this.y = y;
    this.dir = dir;
    this.speX = cos(dir)*spe;
    this.speY = sin(dir)*spe;
    this.vol = vol;
    life = int(vol*50);
    for(int i=0; i<edges; i++) thingy[i] = Variate(Variate(vol));
  }

  void draw(){
    move();
    walls();
    hit();
    render();
  }

  void move(){
    float tmpX = x;
    float tmpY = y;

    x += speX;
    y += speY;

    dirSpe = atan2(y-tmpY,x-tmpX);
  }

  void walls(){
    if(x < 0-vol || y < 0-vol || x > width+vol || y > height+vol){
      act = false;
    }
  }

  void hit(){
    for(int i=0; i<missiles.size(); i++){
      if(dist(x, y, ((Missile) missiles.get(i)).x, ((Missile) missiles.get(i)).y) < vol && ((Missile) missiles.get(i)).owner != 2){
        float tmp;
        tmp = ((Missile) missiles.get(i)).dmg;
        tmp = Variate(tmp);
        tmp = Critmize(tmp);
        ((Missile) missiles.get(i)).act = false;
        life -= int(tmp);
        speX += (cos(((Missile) missiles.get(i)).dir)/vol-cos(((Missile) missiles.get(i)).dir)/(vol*2))*tmp;
        speY += (sin(((Missile) missiles.get(i)).dir)/vol-sin(((Missile) missiles.get(i)).dir)/(vol*2))*tmp;
        textPops.add(new TextPop(str(int(tmp)),x,y,(tmp/5)+10,20,color(255,255,255),"010011"));
        /*
        for(int j=0; j<5; j++){
          missiles.add(new Missile("astroid Piece",((Missile) missiles.get(i)).x,((Missile) missiles.get(i)).y,random(PI*2),1.5,2));
        }
        */
      }
    }
    if(life<1){
      act=false;
    }
  }

  void render(){
    dir += PI/300*(200/vol);
    fill(140,90,40);
    noStroke();
    beginShape();
    //texture(stoneTEXTURE);
    for(int i=0; i<edges; i++){
      vertex(x+cos((2*PI)/edges*i+dir)*thingy[i],y+sin((2*PI)/edges*i+dir)*thingy[i]);
    }
    endShape();
  }
}
